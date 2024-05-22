#!/bin/bash

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

ME="$(whoami)"
DIRECTORY="/home/$ME/Downloads"

#INSTALLING VSCODE
echo "Installing Visual Studio Code"
wget -P "$DIRECTORY" https://code.visualstudio.com/docs/?dv=linux64_deb -O "$DIRECTORY/vscode.deb"

if command -V code &>/dev/null; then
  echo "Visual Studio Code is already installed"
else
  echo "Installing Visual Studio Code..."
#  sudo dpkg -i vscode.deb //uncomment later
fi
