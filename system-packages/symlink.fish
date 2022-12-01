#!/usr/bin/env fish

set DOTFILES_ROOT (git rev-parse --show-toplevel)
set CURRENT_DIR (dirname (status --current-file))

source $DOTFILES_ROOT/fish/functions/outputs.fish
source $DOTFILES_ROOT/fish/functions/symlink_backup.fish

set distro (git config --get dotfiles.distro)

symlink $CURRENT_DIR/bat.config $HOME/.config/bat/config
or fail 'bat config'

function symlink_apt
    mkdir -p $HOME/.local/bin
    symlink (which fdfind) $HOME/.local/bin/fd
    or fail "fdfind to fd"
    symlink (which batcat) $HOME/.local/bin/bat
    or fail "batcat to bat"

end

if test (uname) = Linux
    switch $distro
        case ubuntu debian pop
            symlink_apt
        case '*'
            return
    end
    if command -qa bat
        set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'" # set `man` to use bat
        and success "set `man` to use bat"
        alias --save cat=bat
        and success "set alias cat=bat"
    end
else
    info "use brew to install packages for mac [$(uname)]"
end
