#!/bin/bash

# VARIABLES
ME="$(whoami)"
PACKAGES=("wget" "curl" "apt-transport-https") # add for more if you want to add packages

echo 'Installing the required packages...'

# loop through the PACKAGES variable then install each on of them
for i in "${PACKAGES[@]}"; do
    sudo apt install "$i"
done

echo 'updating packages...'

sudo apt update && sudo apt upgrade -y # update and upgrade the package before installing the packages and softwares

# git-all package
if command --git version &>/dev/null; then
    sudo apt install git-all -y
    echo "GIT successfully installed: $(git --version)"
else
    echo "GIT is already installed: $(git --version)"
fi

#  vs code
if command --code version &>/dev/null; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
    rm -f packages.microsoft.gpg
    sudo apt update
    sudo apt install code
    echo "Vs Code successfully installed: $(code --version)"
else
    echo "Vs Code is already installed: $(code --version)"
fi

# node js and npm
if command node --version &>/dev/null; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
    nvm install 22
    echo "Node.js successfully installed: $(node --version)"
else
    echo "Node.js is already installed: $(node --version)"
fi

# postman
sudo rm -rf /opt/Postman                                                                               # removing postman if already installed
tar -C /tmp/ -xzf <(curl -L https://dl.pstmn.io/download/latest/linux64) && sudo mv /tmp/Postman /opt/ # downloading and extracting
# creating a software shortcut
sudo tee -a /usr/share/applications/postman.desktop <<END
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
END
echo "Postman successfully installed"

# postgres
if command postgres --version &>/dev/null; then
    sudo apt install postgres -y
    echo "postgres successfully installed: $(postgres --version)"
else
    echo "postgres is already installed: $(postgres --version)"
fi

# mongodb
if command mongod --version &>/dev/null; then
    curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc |
        sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
            --dearmor
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org
    echo "mongodb successfully installed: $(mongodb --version)"
else
    echo "mongodb is already installed: $(mongodb --version)"
fi

# github desktop
if
    command apt show github-desktop | grep Version
    &>/dev/null
then
    wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg >/dev/null
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
    sudo apt update && sudo apt install github-desktop
    echo "github desktop successfully installed"
else
    echo "postgres is already installed"
fi
