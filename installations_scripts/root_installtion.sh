#!/bin/bash

# Check if script is run with root privilege
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Create user
sudo adduser zubbyik

# Add user to sudo group
sudo usermod -aG sudo zubbyik

user_home="/home/zubbyik"
sudo usermod -d $user_home zubbyik

# Update and upgrade system
sudo apt-get update
sudo apt-get upgrade -y

# Create installation log file
install_log="/var/log/installation_log.txt"
touch $install_log

# Log initial message
echo "Root installation script started at $(date)" >>$install_log

# Update and upgrade system
sudo apt-get update >>$install_log 2>&1
sudo apt-get upgrade -y >>$install_log 2>&1

sudo cp $PWD/user_installation.sh $user_home
