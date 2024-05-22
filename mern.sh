#!/bin/bash

# VARIABLES
ME="$(whoami)"
DIRECTORY="/home/$ME/Downloads"

updating_packages=$(
  cat <<'EOF'
               _      _   _                          _                    
  _  _ _ __ __| |__ _| |_(_)_ _  __ _   _ __ __ _ __| |____ _ __ _ ___ ___
 | || | '_ / _` / _` |  _| | ' \/ _` | | '_ / _` / _| / / _` / _` / -_(_-<
  \_,_| .__\__,_\__,_|\__|_|_||_\__, | | .__\__,_\__|_\_\__,_\__, \___/__/
      |_|                       |___/  |_|                   |___/        
EOF
)
echo "$updating_packages"

echo "Installing  wget"
# sudo apt install wget -y //uncomment later

# updating packages before installing the softwares
#sudo apt update -y && sudo apt upgrade -y //uncomment later

#INSTALLING VSCODE
if command -V code &>/dev/null; then
  echo "Visual Studio Code is already installed"
  code --version
else
  echo "Downloading Visual Studio Code..."
  wget -P "$DIRECTORY" https://code.visualstudio.com/docs/?dv=linux64_deb -O "$DIRECTORY/vscode.deb"
  echo "Installing Visual Studio Code..."
  # sudo dpkg -i "$DIRECTORY/vscode.deb" -y //uncomment later
fi

if command -V code &>/dev/null; then
  echo "Successfully Installed Visual Studio Code"
  code --version
fi

# fix missing dependecies
sudo apt install -f -y

# installing git
if command -V git &>/dev/null; then
  echo "git already installed"
  git --version
else
  echo "Installing Git..."
  # sudo apt install git-all -y //uncomment later
fi

if command -V git &>/dev/null; then
  echo "Successfully Installed Git"
  git --version
fi

# installing Github Desktop
if command -V github-desktop &>/dev/null; then
  echo "github desktop already installed"
else
  echo "Downloading Github Desktop..."
  wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg >/dev/null
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
  sudo apt update && sudo apt install github-desktop -y
fi

if command -V github-desktop &>/dev/null; then
  echo "Successfully Installed Github Desktop"
fi

# postman installation
# removing if postman i installed
sudo rm -rf /opt/Postman
# this sill install postman to /tmp and move it to directory /opt/
tar -C /tmp/ -xzf <(curl -L https://dl.pstmn.io/download/latest/linux64) && sudo mv /tmp/Postman /opt/
# creating a desktop file
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

# MONGODB
if command -V mongod &>/dev/null; then
  echo "Mongodb is already installed"
  mongod --version
else
  sudo apt-get install gnupg curl

  # importing GPG key
  curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc |
    sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
      --dearmor

  # create the list file /etc/apt/sources.list.d/mongodb-org-7.0.
  echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

  # updateing package
  sudo apt-get update

  # installing mongodb
  sudo apt-get install -y mongodb-org
fi

# MONGODB COMPASS
if command -V mongodb-compass &>/dev/null; then
  echo "Mongodb Compass is already Installed"
else
  wget -P "$DIRECTORY" https://downloads.mongodb.com/compass/mongodb-compass_1.43.0_amd64.deb?_ga=2.37725479.626895300.1716344003-1779870393.1716344002 -O "$DIRECTORY/mongodb_compass.deb"
  # sudo dpkg -i "$DIRECTORY/mongodb_compass.deb" -y //uncomment later
fi

# Install prerequisites
echo "Installing prerequisites..."
sudo apt-get install -y curl apt-transport-https

# Install Spotify
if is_installed "spotify-client"; then
  echo "Spotify is already installed."
else
  echo "Installing Spotify..."
  # Add the Spotify repository signing key
  curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
  # Add the Spotify repository
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  # Update package list and install Spotify
  sudo apt-get update -y
  sudo apt-get install -y spotify-client
  if [ $? -eq 0 ]; then
    echo "Spotify installed successfully."
  else
    echo "Failed to install Spotify."
    exit 1
  fi
fi

# Install Discord
if is_installed "discord"; then
  echo "Discord is already installed."
else
  echo "Installing Discord..."
  # Download Discord .deb package
  wget -O ~/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
  # Install Discord
  sudo dpkg -i ~/discord.deb
  sudo apt-get install -f -y # Fix dependencies if needed
  if [ $? -eq 0 ]; then
    echo "Discord installed successfully."
    rm ~/discord.deb # Clean up the .deb file
  else
    echo "Failed to install Discord."
    exit 1
  fi
fi

# Clean up
echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get clean

echo "Installation complete!"
