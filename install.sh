#!/bin/bash

sudo touch log.txt;
sudo ./lp.sh --create-user-status;

echo -n "Digite uma cota: ";
read -a quota;
sudo ./lp.sh --quota $quota;

sudo g++ lp.cpp -o lp;

sudo chmod 4755 lp;
