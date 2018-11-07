#!/bin/bash

file_path=$1;
username=$USER;


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
}

status=$(./check_user_quota.sh $username);

if [ $? -eq 0 ] ; then
    user_quota=$(cat user-status.txt | grep "$username" | awk '{print $2}');
    file_pages=$(count_pages $file_path);
    consumed=$(expr $user_quota + $file_pages);
    echo $consumed;
    replace_consumed_quota $consumed;
    add_log "Success!" $file_pages;
else
    add_log "$status" $(count_pages $file_path);
fi
