#!/bin/bash

user=$1;
quota=$(cat quota.txt);
consumed=$(cat table.txt | grep $user | awk '{print $2}'); 

if [ $consumed -gt $quota ] ; then
    echo "Quota exceeded!";
else
    echo "Everything OK!";
fi

