#!/bin/bash

DISTRO=""

function askDistro {
	while true; do
	    read -p "$1" mu
	    case $mu in
	        [Mm]* ) DISTRO="manjaro";break;;
	        [Uu]* ) DISTRO="ubuntu";break;;
	        * ) echo "Please answer manjaro or ubuntu.";;
	    esac
	done
}

function installManjaro {
	printf "\nNeed packages alacritty, fish, tmux, git and curl\n\n"
	sleep 1
	pacman -Sy alacritty fish tmux git curl
	
	snap install micro --classic
}

function installUbuntu {
	printf "\nNeed to add repository for alacritty\n"
	add-apt-repository ppa:mmstick76/alacritty

	printf "\nNeed packages alacritty, fish, tmux, git and curl\n\n"
	apt-get update
	apt-get install alacritty fish tmux git curl

	snap install micro --classic
}

askDistro "[M]anjaro or [U]buntu? [m/u] "

if [ $DISTRO == "manjaro" ]; then
	installManjaro;
else
	installUbuntu
fi


