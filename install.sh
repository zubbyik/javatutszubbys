#!/bin/bash

#Set up script for Ubuntu 22.04 server
#Create new user "zubbyik" and add to sudo group
useradd -m -s /bin/bash zubbyik
usermod -aG sudo zubbyik

#Update and upgrade the system
apt-get update && apt-get upgrade -y

#Install required packages
apt-get install -y zip rar build-essential unrar unzip

#Install pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

#Install Node.js, NVM, NPM, Yarn, Nodemon
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install --lts
npm install -g yarn nodemon

#Install Docker and Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
systemctl enable docker.service
systemctl enable containerd.service
apt-get install -y docker-compose

#Install sdkman
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

#Install JRE/JDK and Gradle
sdk install java
sdk install gradle

#Install Python and Poetry
apt-get install -y python3 python3-pip
pip3 install poetry

#Install httpie
apt-get install -y httpie

echo "Setup completed successfully!"