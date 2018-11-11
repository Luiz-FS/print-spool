#!/bin/bash

function refresh {
    quota=$(cat quota.txt);
    awk -v quota=$quota '{ if (NR == 1) print $1 " " $2 } {if (NR != 1 && $2 - quota > 0) print $1 " " $2 - quota; else if (NR != 1) print $1 " "  0;}' user-status.txt > temp.txt;
    mv temp.txt user-status.txt;    
}

function create_user_status_file {
    users=`ls /home`;
    echo "User Consumed" > user-status.txt;
    echo "$users" | awk '{print $1 " " 0}' >> user-status.txt;
    echo "root 0" >> user-status.txt;
}


case $1 in 
    --refresh)
	    echo "Refreshing...";
	    refresh;
    ;;
    --quota)
        echo "Setting quota...";
        new_quota=$2;
        echo $new_quota > quota.txt;
    ;;
    --create-user-status)
        echo "Creating user status file...";
        echo "Date time user file pages status" > log.txt;
        create_user_status_file;
    ;;
    --add-user)
        username=$2;
        echo "Adding user $username...";
        echo "$username 0" >> user-status.txt;
    ;;
    *)
        echo "Option not found.";
    ;;
esac