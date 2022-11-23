#!/usr/bin/env fish

set -l DOTFILES_ROOT (git rev-parse --show-toplevel)
set -l CURRENT_DIR (dirname (status --current-file))

source $DOTFILES_ROOT/fish/functions/outputs.fish
source $DOTFILES_ROOT/fish/functions/symlink_backup.fish

subtitle 'symlink fish'
symlink $CURRENT_DIR/functions $__fish_config_dir/functions
or fail 'functions directory'
symlink $CURRENT_DIR/config.fish $__fish_config_dir/config.fish
or fail 'config.fish'

# fisher-plugins
