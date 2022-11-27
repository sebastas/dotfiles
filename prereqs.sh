#!/usr/bin/env bash

# Colors
Normal='\033[0m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'

# Add fish repository and install latest for ubuntu
function install_ubuntu {
    echo -e "${Cyan}===== INSTALLING FISH ====="
    echo -e "${Purple}===== Adding PPA repository [sudo] =====${Normal}"
    sudo apt-add-repository ppa:fish-shell/release-3 -y
    echo -e "\n${Purple}Updating (apt update) =====${Normal}"
    sudo apt update -y
    echo -e "\n${Purple}===== Installing fish (apt install) =====${Normal}"
    sudo apt install fish -y
    echo -e "\n${Purple}===== Installing jq (apt install) =====${Normal}"
    sudo apt install jq -y
    if [ -n $(command -v fish) ]
    then
        echo -e "\n${Green}===== fish installed =====${Normal}\n"
    else
    	echo -e "${Red}===== fish wasn't installed, try again =====\n"
    fi
}

# Check out https://software.opensuse.org/download.html?project=shells%3Afish&package=fish for more info
# Add repo and install for debian 11 (bullseye)
function install_debian {
    echo -e "${Cyan}===== INSTALLING FISH ====="
    echo -e "${Purple}===== Adding repository [sudo] =====${Normal}"
    echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish.list
    curl -fsSL https://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
    echo -e "\n${Purple}Updating (apt update) =====${Normal}"
    sudo apt update -y
    echo -e "\n${Purple}===== Installing fish (apt install) =====${Normal}"
    sudo apt install fish -y
    echo -e "\n${Purple}===== Installing jq (apt install) =====${Normal}"
    sudo apt install jq -y
    if [ -n $(command -v fish) ]
    then
        echo -e "\n${Green}===== fish installed =====${Normal}\n"
    else
    	echo -e "${Red}===== fish wasn't installed, try again =====\n"
    fi
}

# Main
if [ $(uname) = 'Linux' ]
then
    distro=$(grep "^ID=" /etc/os-release | sed -E 's/ID=(.*)/\1/')
    echo -e "\n${Blue}Linux distro detected: ${Yellow}${distro}"
else
    echo "No linux distro detected"
    exit 0
fi
# Install fish for distro
case $distro in
    ubuntu | pop) install_ubuntu ;;
    debian ) install_debian ;;
    fedora ) dnf install -y fish jq ;;
    manjaro | arch ) pacman -S --noconfirm fish jq ;;
    * ) echo -e "${Red}This installer doesn't support [${distro}]${Normal}" ;;
esac
