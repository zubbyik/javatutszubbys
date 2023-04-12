#!/bin/bash

# Set up new user and add to sudo group
sudo adduser zubbyik
sudo usermod -aG sudo zubbyik

# Generate SSH key without passphrase
#ssh-keygen -t rsa -b 4096 -C zubbyik@gmail.com -N "" -f ~/.ssh/id_rsa

# Update and upgrade the system
sudo apt-get update
sudo apt-get upgrade -y

# Install required packages
sudo apt-get install -y vim git curl wget zip rar python httpie

# Install Node.js and related tools
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install --lts
npm install -g yarn nodemon

# Install Docker and Docker Compose
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER

# Install SDKMAN and Java
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java
sdk install gradle

# Install Poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
source $HOME/.poetry/env

# Cleanup
sudo apt-get autoremove -y
