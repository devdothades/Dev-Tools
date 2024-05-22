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
else
  echo "Downloading Visual Studio Code..."
  wget -P "$DIRECTORY" https://code.visualstudio.com/docs/?dv=linux64_deb -O "$DIRECTORY/vscode.deb"
  echo "Installing Visual Studio Code..."
  # sudo dpkg -i "$DIRECTORY/vscode.deb" //uncomment later
fi

if command -V code &>/dev/null; then
  echo "Successfully Installed Visual Studio Code"
fi

# fix missing dependecies
sudo apt install -f -y

# installing git
if command -V git &>/dev/null; then
  echo "git already installed"
else
  echo "Installing Git..."
  # sudo apt install git-all //uncomment later
fi

if command -V git &>/dev/null; then
  echo "Successfully Installed Git"
fi

# installing Github Desktop
if command -V github-desktop &>/dev/null; then
  echo "github desktop already installed"
else
  echo "Downloading Github Desktop..."
  wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg >/dev/null
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
  sudo apt update && sudo apt install github-desktop
fi

if command -V github-desktop &>/dev/null; then
  echo "Successfully Installed Github Desktop"
fi