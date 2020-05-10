#!/bin/bash

DISTRO=""

function ask {
	while true; do
	    read -p "$1" yn
	    case $yn in
	        [Yy]* ) return 1;;
	        [Nn]* ) exit;;
	        * ) echo "Please answer yes or no.";;
	    esac
	done
}

function askDistro {
	while true; do
	    read -p "$1" au
	    case $au in
	        [Aa]* ) DISTRO="arch";break;;
	        [Uu]* ) DISTRO="ubuntu";break;;
	        * ) echo "Please answer arch or ubuntu.";;
	    esac
	done
}

function installArch {
	printf "\nNeed packages alacritty, fish, tmux, git and curl\n\n"
	sleep 1
	pacman -S alacritty fish tmux git curl
	
	snap install micro --classic
}

function installUbuntu {
	printf "\nNeed to add repository for alacritty\n"
	add-apt-repository ppa:mmstick76/alacritty

	printf "\nNeed packages alacritty, fish, tmux, git and curl\n\n"
	apt-get install allacrity fish tmux git curl
}

askDistro "[A]rch or [U]buntu? [a/u] "

if [ $DISTRO == "arch" ]; then
	installArch;
else
	installUbuntu
fi

printf "Installing Oh My Fish! \n"
curl -L https://get.oh-my.fish | fish

