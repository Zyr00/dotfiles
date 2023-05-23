#!/usr/bin/env bash

##############
# Guides
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_basic_system_settings/using-chrony-to-configure-ntp_configuring-basic-system-settings
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_basic_system_settings/using-chrony_configuring-basic-system-settings
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-configuring_ntp_using_the_chrony_suite#sect-differences_between_ntpd_and_chronyd
#
# Settings file in
# /etc/chrony/chrony.conf
#
##############

echo -e "\nDisabling timedatectl ntp\n"
sudo timedatectl set-ntp off

echo -e "\nInstalling chrony ntp client\n"
sudo apt install chrony -y

if [ -z "$1" ]; then
	echo -e "\nNot configuring chronyd no server passed as argument\n"
else
	echo -e "\nConfiguring with server $1\n"
	echo "server $1 iburst" | sudo tee -a /etc/chrony/chrony.conf
fi

echo -e "\nEnabling and starting the ntp service\n"
sudo systemctl enable chronyd
sudo systemctl restart chronyd

echo -e "\nShowing current date and time\n"
date
