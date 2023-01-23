#!/usr/bin/env fish

set DOTFILES_ROOT (git rev-parse --show-toplevel)
set CURRENT_DIR (dirname (status --current-file))

source $DOTFILES_ROOT/fish/functions/outputs.fish
source $DOTFILES_ROOT/fish/functions/symlink_backup.fish

symlink $CURRENT_DIR/config.fish $__fish_config_dir/config.fish
or fail 'config.fish'
symlink $CURRENT_DIR/functions/fish_prompt.fish $__fish_config_dir/functions/fish_prompt.fish
or fail 'fish_prompt.fish'
symlink $CURRENT_DIR/functions/git_functions.fish $__fish_config_dir/functions/git_functions.fish
or fail 'git_functions.fish'
symlink $CURRENT_DIR/functions/outputs.fish $__fish_config_dir/functions/outputs.fish
or fail 'outputs.fish'
symlink $CURRENT_DIR/functions/symlink_backup.fish $__fish_config_dir/functions/symlink_backup.fish
or fail 'symlink_backup.fish'
symlink $CURRENT_DIR/fish_plugins $__fish_config_dir/fish_plugins
or fail 'fish_plugins file'
symlink $CURRENT_DIR/functions/__kube_prompt.fish $__fish_config_dir/functions/__kube_prompt.fish
or fail 'kube_prompt.fish'
