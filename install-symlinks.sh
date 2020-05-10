#!/bin/bash

dotfiles=~/dotfiles

# Delete existing dot files and folders
rm -rf ~/.tmux.conf > /dev/null 2>&1
rm -rf ~/.config/alacritty > /dev/null 2>&1
rm -rf ~/.config/fish > /dev/null 2>&1

# Create directory for alacritty config
mkdir ~/.config/alacritty

# Create symlinks
ln -svf $dotfiles/alacritty.yml ~/.config/alacritty/
ln -svf $dotfiles/fish ~/.config/
ln -svf $dotfiles/.tmux.conf ~/


# Change default shell to fish
printf "\nChanging default shell to fish:\n"
chsh -s /usr/bin/fish
