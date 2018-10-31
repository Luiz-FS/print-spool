#!/bin/bash

users=`ls /home`
#echo "$users"

echo "User Consumed" > user-status.txt;

echo "$users" | awk '{print $1 " " 0}' >> user-status.txt
