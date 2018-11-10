#!/bin/bash

sudo ./lp-config.sh --create-user-status;

echo -n "Digite uma cota: ";
read -a quota;
sudo ./lp-config.sh --quota $quota;

sudo g++ lp.cpp -o lp;

sudo chmod 4755 lp;
sudo chmod 700 lp-config.sh;
sudo chmod 700 lp.sh;
