#!/bin/bash

file_path=$1;
username=$USER;
quota=$(cat quota.txt);

function check_user_quota {
    user=$1;
    consumed=$(cat user-status.txt | grep $user | awk '{print $2}');

    if [ $consumed -gt $quota ] ; then
        echo "Quota exceeded!";
        exit 1;
    else
        echo "Everything OK!";
        exit 0;
    fi
}

function replace_consumed_quota {
    consumed=$1;
    sed -i '/'"$username"'/ s/[0-9]\+/'"$consumed"'/g' user-status.txt
}

function count_pages {
    path=$1;
    file_size=$(ls -l $path | awk '{print $5}');
    echo "a=$file_size; b=3600; if ( a%b ) a/b+1 else a/b" | bc;
}

function add_log {
    job_status=$1;
    page_number=$2;
    date_now="$(date +\%F) $(date +\%T)";
    message="$date_now $username $file_path $page_number $job_status";
    echo $message >> log.txt;
    echo "$job_status";
}

function refresh {
    awk -v quota=$quota '{ if (NR == 1) print $1 " " $2 } {if (NR != 1 && $2 - quota > 0) print $1 " " $2 - quota; else if (NR != 1) print $1 " "  0;}' user-status.txt > temp.txt;
    mv temp.txt user-status.txt;    
}

function main {
    status=$(check_user_quota $username);

    if [ $? -eq 0 ] ; then
        user_quota=$(cat user-status.txt | grep "$username" | awk '{print $2}');
        file_pages=$(count_pages $file_path);
        consumed=$(expr $user_quota + $file_pages);
        replace_consumed_quota $consumed;
        add_log "Success!" $file_pages;
    else
        add_log "$status" $(count_pages $file_path);
    fi
}

case $1 in 
    --refresh)
	echo "Refreshing...";
	refresh;
    ;;
    *)
        main;
    ;;
esac
