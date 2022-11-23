#!/usr/bin/env fish

set DOTFILES_ROOT (git rev-parse --show-toplevel)
set CURRENT_DIR (dirname (status --current-file))

source $DOTFILES_ROOT/fish/functions/outputs.fish
source $DOTFILES_ROOT/fish/functions/symlink_backup.fish

set latest_micro
set current_micro
set latest false

# Installs jq prerequisites
function install_prereq
    if test -e /usr/bin/jq
        # info 'prereq is installed'
    else
        info 'make sure jq is installed to get latest version of micro. installing now...'
        sudo apt install -qq jq &>/dev/null
        and success "jq installed"
    end
end

# Checks for updates
function check_latest
    set latest_micro (curl -sL https://api.github.com/repos/zyedidia/micro/releases/latest | jq -r ".tag_name")
    or fail 'unable to retrieve the latest micro version...'

    set current_micro v(micro -version | grep 'Version' | awk '{print $2}')
    or fail 'unable to retrieve the current micro version...'
end

# Downloads latest binary
function download_micro
    cd $DOTFILES_ROOT/micro
    curl -sS https://getmic.ro | bash &>/dev/null
    if test -e micro
        success 'latest micro downloaded'
    else
        fail "micro wasn't downloaded"
    end
    sudo mv micro /usr/bin/
end

# Updates binary by downloading latest and replacing, only if not on latest
function update_micro
    check_latest
    if test "$current_micro" = "$latest_micro"
        set latest true
        success "micro is already installed and up-to-date [$current_micro]"
        exit 0
    else
        set latest false
        info "updating micro from [$current_micro]..."
        download_micro
        if test -e /usr/bin/micro
            success "micro updated to [$latest_micro]"
        else
            fail "micro wasn't installed in /usr/bin/"
        end
    end
end

# Install
function install_micro
    if test -e /usr/bin/micro
        update_micro
    else
        download_micro
        if test -e /usr/bin/micro
            success "micro installed"
        else
            fail "micro wasn't installed in /usr/bin/"
        end
    end
end

# Main function calls
install_prereq
install_micro
