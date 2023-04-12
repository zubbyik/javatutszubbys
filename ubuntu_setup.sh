#!/bin/bash

# Check if script is run with root privilege
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Create user
sudo adduser zubbyik

# Add user to sudo group
sudo usermod -aG sudo zubbyik

# Update and upgrade system
sudo apt-get update
sudo apt-get upgrade -y

# Install required packages
sudo apt-get install -y wget zip rar build-essential unrar unzip

# Install pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# Install Node.js, NVM, NPM, Yarn, and Nodemon
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install --lts
npm install -g yarn nodemon

# Install Docker and Docker-compose
sudo apt-get install -y docker.io docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER

# Install sdkman and Java
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java

# Install Gradle
sdk install gradle

# Install Python and Poetry
sudo apt-get install -y python3-pip
pip3 install poetry

# Install httpie
sudo apt-get install -y httpie

echo "Setup completed successfully!"

#logout from the system
logout