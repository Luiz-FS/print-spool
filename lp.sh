#!/bin/bash

file_path=$1;
username=$USER;


function replace_consumed_quota {
    consumed=$1;
    sed -i '/'"$username"'/ s/[0-9]\+/'"$consumed"'/g' user-status.txt
}

function count_pages {
    page_bytes=$1;
    echo "a=$page_bytes; b=3600; if ( a%b ) a/b+1 else a/b" | bc
}

./check_user_quota.sh $username

if [ $? -eq 0 ] ; then
    file_size=$(ls -l $file_path | awk '{print $5}');
    user_quota=$(cat user-status.txt | grep "$username" | awk '{print $2}');
    file_pages=$(count_pages $file_size);
    consumed=$(expr $user_quota + $file_pages);
    echo $consumed;
    replace_consumed_quota $consumed;
fi
