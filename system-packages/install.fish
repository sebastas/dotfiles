#!/usr/bin/env fish

set DOTFILES_ROOT (git rev-parse --show-toplevel)
set CURRENT_DIR (dirname (status --current-file))

source $DOTFILES_ROOT/fish/functions/outputs.fish
source $DOTFILES_ROOT/fish/functions/symlink_backup.fish

set distro (git config --get dotfiles.distro)

# Packages to be downloaded with apt (ubuntu, debian, pop)
set apt_packages fd-find bat fzf

function install_apt
    for package in $apt_packages
        if test (dpkg -l | grep -w $package)
            success "$package already installed"
        else
            info "installing $package..."
            sudo apt install -qq $package &>/dev/null -y
            and success "installed $package"
        end
    end
end

if test (uname) = Linux
    switch $distro
        case ubuntu debian pop
            install_apt
        case '*'
            info "unable to install packages for [$distro]"
    end
else
    info "use brew to install for mac [$(uname)]"
end
