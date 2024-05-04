#!/bin/bash

# Check if script is run with root privilege
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Create user
sudo adduser zubbyik

# Add user to sudo group
sudo usermod -aG wheel zubbyik

# Update and upgrade system
sudo dnf update -y
sudo dnf upgrade -y

# Install required packages
sudo dnf install -y tree wget zip unzip gcc-c++ make git

# Install pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# Add pyenv to bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
source ~/.bashrc

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
npm install -g nodemon

# Install Docker and Docker-compose
sudo dnf remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker $USER

# Verify that the Docker Engine installation is successful by running the hello-world image:
sudo docker run hello-world

# Install Caddy server
sudo dnf install -y caddy

# Install sdkman and Java
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java

# Install Gradle
sdk install gradle

# Install Python and Poetry
sudo dnf install -y python3-pip
pip3 install poetry

# Install httpie
sudo dnf install -y httpie

echo "Setup completed successfully!"

# Logout from the system
logout

