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

# vivid is not available in apt
function install_vivid
    if test -e /usr/bin/vivid
        set -l latest_vivid (curl -sL https://api.github.com/repos/sharkdp/vivid/releases/latest | jq -r ".tag_name")
        or fail "unable to retrieve the latest vivid version..."

        set -l current_vivid v(vivid --version | awk '{print $2}')
        if test $current_vivid = $latest_vivid
            success "vivid is already installed and up-to-date [$current_vivid]"
            exit 0
        end
    end
    info "installing vivid..."
    set -l latest_vivid_download (curl -sL https://api.github.com/repos/sharkdp/vivid/releases/latest | jq -r '.assets[] | select(.name|match("amd64.deb")) | select(.name|contains("musl")|not) | .browser_download_url')
    or fail "unable to retrieve latest vivid release..."
    wget $latest_vivid_download -O vivid.deb &>/dev/null
    sudo dpkg -i vivid.deb &>/dev/null
    rm vivid.deb
    if test -e /usr/bin/vivid
        success "installed vivid"
    else
        fail "vivid wasn't installed"
    end
end

if test (uname) = Linux
    switch $distro
        case ubuntu debian pop
            install_apt
            install_vivid
        case '*'
            info "unable to install packages for [$distro]"
    end
else
    info "use brew to install for mac [$(uname)]"
end
