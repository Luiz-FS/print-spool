#!/bin/bash

user=$1;
quota=$(cat quota.txt);
consumed=$(cat user-status.txt | grep $user | awk '{print $2}'); 

if [ $consumed -gt $quota ] ; then
    echo "Quota exceeded!";
    exit 1;
else
    echo "Everything OK!";
    exit 0;
fi

