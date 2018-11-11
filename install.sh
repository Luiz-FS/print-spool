#!/bin/bash

sudo ./lp-config.sh --create-user-status;

echo -n "Digite uma cota: ";
read -a quota;
sudo ./lp-config.sh --quota $quota;

sudo g++ lp.cpp -o lp;

sudo chmod 4755 lp;
sudo chmod 700 lp-config.sh;
sudo chmod 700 lp.sh;
sudo chown root:root lp-config.sh;
sudo chown root:root lp.sh;

lp_path=$(dirname `which lp`);
sudo mv $lp_path/lp $lp_path/lp-orig;
sudo chmod 700 $lp_path/lp-orig;

sudo mkdir /usr/lib/lp;
sudo ln -s /usr/lib/lp/lp $lp_path/lp;
sudo ln -s /usr/lib/lp/lp-config.sh $lp_path/lp-config;

echo "0 0 1 * * root ./usr/lib/lp/lp-config.sh --refresh" >> /var/spool/cron/contrabs/root;
