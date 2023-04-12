#!/bin/bash

# Ensure that script is run with elevated privileges
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root or with sudo" >&2
  exit 1
fi

# Create user zubbyik
adduser zubbyik

# Add user zubbyik to sudo group
usermod -aG sudo zubbyik

# Update and upgrade system
apt update && apt upgrade -y

# Install required packages
apt install -y wget zip rar build-essential unrar unzip pyenv

# Install Node.js using NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source $HOME/.bashrc
nvm install node
npm install -g yarn nodemon

# Install Docker and Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
systemctl start docker
systemctl enable docker
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install SDKMAN
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Install JRE/JDK, Gradle, and other tools using SDKMAN
sdk install java
sdk install gradle
sdk install maven
sdk install sbt

# Install Python and Poetry
apt install -y python3-pip
pip3 install poetry

# Install httpie
apt install -y httpie

# Logout current user
logout
