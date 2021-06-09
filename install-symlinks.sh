#!/bin/bash

# Delete existing dot files and folders
rm -rf ~/.tmux.conf > /dev/null 2>&1
rm -rf ~/.config/alacritty > /dev/null 2>&1
rm -rf ~/.config/fish > /dev/null 2>&1
rm -rf ~/.gitconfig > /dev/null 2>&1
rm -rf ~/.toggle-terminal.sh > /dev/null 2>&1

# Create symlinks
ln -svf ~/dotfiles/alacritty ~/.config/
ln -svf ~/dotfiles/fish ~/.config/
ln -svf ~/dotfiles/tmux/.tmux.conf ~/
ln -svf ~/dotfiles/.gitconfig ~/
ln -svf ~/dotfiles/.toggle-terminal.sh ~/


# Change default shell to fish
printf "\nChanging default shell to fish:\n"
chsh -s /usr/bin/fish


# Install omf
printf "Installing Oh My Fish! \n"
curl -L https://get.oh-my.fish | fish
