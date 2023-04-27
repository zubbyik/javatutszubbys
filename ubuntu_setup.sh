#!/bin/bash

# Check if script is run with root privilege
# if [ "$EUID" -ne 0 ]
#   then echo "Please run as root"
#   exit
# fi

# Create user
sudo adduser zubbyik

# Add user to sudo group
sudo usermod -aG sudo zubbyik

# Update and upgrade system
sudo apt-get update
sudo apt-get upgrade -y

# Install required packages
sudo apt-get install -y tree ca-certificates wget zip rar build-essential unrar unzip gnupg

# Install pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# Add to pyenv environment to bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# Install Node.js, NVM, NPM, Yarn, and Nodemon
# Install NVM and verify installation

export NVM_DIR="$HOME/.nvm"

# Check if nvm is already installed
if [ -d "$NVM_DIR" ]; then
    echo "nvm is already installed in $NVM_DIR"
else
    # Clone nvm repository
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"

    # Check out the latest tag
    latest_tag=$(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
    git checkout "$latest_tag"
fi

# Load nvm
source "$NVM_DIR/nvm.sh"


echo '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
' >> $HOME/.bashrc

nvm --version || exit 1

# Install latest version of Node.js using NVM
nvm install node

# Install Yarn
npm install -g yarn

# Install Nodemon
npm install -g yarn nodemon

# Install Docker and Docker-compose

sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER

# Verify that the Docker Engine installation is successful by running the hello-world image:
sudo docker run hello-world

# Create the docker group
sudo groupadd docker


# Add your user to the docker group.
sudo usermod -aG docker $USER


source $HOME/.bashrc

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