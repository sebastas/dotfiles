#!/usr/bin/env fish

set -l DOTFILES_ROOT (git rev-parse --show-toplevel)
set -l CURRENT_DIR (dirname (status --current-file))

source $DOTFILES_ROOT/fish/functions/outputs.fish
source $DOTFILES_ROOT/fish/functions/symlink_backup.fish

subtitle 'symlink micro'
symlink $CURRENT_DIR/bindings.json $HOME/.config/micro/bindings.json backup
or fail 'bindings.json'
symlink $CURRENT_DIR/settings.json $HOME/.config/micro/settings.json backup
or fail 'settings.json'
