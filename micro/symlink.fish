#!/usr/bin/env fish

set DOTFILES_ROOT (git rev-parse --show-toplevel)
set CURRENT_DIR (dirname (status --current-file))

source $DOTFILES_ROOT/fish/functions/outputs.fish
source $DOTFILES_ROOT/fish/functions/symlink_backup.fish

subtitle 'symlink micro'
symlink $CURRENT_DIR/bindings.json $HOME/.config/micro/bindings.json
or fail 'bindings.json'
symlink $CURRENT_DIR/settings.json $HOME/.config/micro/settings.json
or fail 'settings.json'
