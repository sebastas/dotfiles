#!/usr/bin/env fish

cd (dirname (status --current-file)) # sets CURRENT_DIR to be able to retrieve DOTFILES_ROOT

set DOTFILES_ROOT (git rev-parse --show-toplevel)
set CURRENT_DIR (dirname (status --current-file))

source $DOTFILES_ROOT/fish/functions/outputs.fish
source $DOTFILES_ROOT/fish/functions/symlink_backup.fish

# Set script greeting
function greeting
    set ascii_art "
          _               _               __  _       _    __ _ _           
 ___  ___| |__   __ _ ___| |_ __ _ ___   / /_| | ___ | |_ / _(_) | ___  ___ 
/ __|/ _ \ '_ \ / _` / __| __/ _` / __| / / _` |/ _ \| __| |_| | |/ _ \/ __|
\__ \  __/ |_) | (_| \__ \ || (_| \__ \/ / (_| | (_) | |_|  _| | |  __/\__ \\
|___/\___|_.__/ \__,_|___/\__\__,_|___/_/ \__,_|\___/ \__|_| |_|_|\___||___/
                                                                            
"
    echo (set_color 008080)$ascii_art'Running bootstrap script...'(set_color normal)
end

# Initializes the .gitconfig file
function init_gitconfig
    title GITCONFIG
    set managed (git config --global --get dotfiles.managed) # check if config is managed by dotfiles
    # if there is no user.email, prompt user for name and email
    if test -z (git config --global --get user.email)
        subtitle 'setting up new git user'
        read -P (user "What is your git author name? [user.name] > ") -l user_name
        test -n $user_name
        or fail 'please fill in the git author name'

        read -P (user "What is your git author email? [user.email] > ") -l user_email
        test -n $user_email
        or fail 'please fill in the git author email'

        git config --global user.name $user_name
        and info "new git user.name set [$user_name]"
        and git config --global user.email $user_email
        and info "new git user.email set [$user_email]"
        or fail 'failed to setup git user name and email'

        manage_gitconfig

    else if test "$managed" != true
        # if user.email exists, check for dotfiles.managed config. If it is
        # not true, we'll backup the gitconfig file and set previous user.email and
        # user.name in the new one
        set user_name (git config --global --get user.name)
        set user_email (git config --global --get user.email)
        info 'gitconfig is not managed by dotfiles yet'
        info 'backing up existing gitconfig...'
        mv $HOME/.gitconfig $HOME/.gitconfig.backup
        and success "backed up $HOME/.gitconfig to $HOME/.gitconfig.backup"
        git config --global user.name $user_name
        git config --global user.email $user_email

        manage_gitconfig
    else
        # otherwise the gitconfig is already managed by dotfiles
        success 'gitconfig is already managed by dotfiles'
    end
end

# Manages the .gitconfig
function manage_gitconfig
    subtitle 'managing gitconfig'
    # include the dotfiles-managed gitconfig file
    git config --global include.path $DOTFILES_ROOT/git/.gitconfig
    or fail 'failed to include dotfiles managed gitconfig'
    # set dotfiles.managed to true so git knows this is a managed config
    # and to prevent later overrides by this script
    git config --global dotfiles.managed true
    and success 'gitconfig now managed by dotfiles'
    or fail 'failed to manage gitconfig with dotfiles'

    git config --global dotfiles.uname (uname)
    if test (git config --get dotfiles.uname) = Linux
        git config --global dotfiles.distro (grep "^ID=" /etc/os-release | sed -E 's/ID=(.*)/\1/')
    end
    prompt_alacritty # prompt for alacritty install
end

function prompt_alacritty
    while true
        read -P (user "Do you want to install alacritty? [y/N] > ") -l alacritty
        switch $alacritty
            case Y y
                git config --global dotfiles.alacritty true
                and info 'alacritty will be installed'
                return
            case '' N n
                git config --global dotfiles.alacritty false
                and info 'alacritty will not be installed'
                return
            case '*'
                info 'please enter a valid value [y/N]'
        end
    end
end

function install_dotfiles
    title 'INSTALL DOTFILES'
    for src in $DOTFILES_ROOT/*/install.fish
        subtitle installing (basename (dirname $src))
        $src
    end
end

function symlink_dotfiles
    title 'SYMLINK DOTFILES'
    for src in $DOTFILES_ROOT/*/symlink.fish
        subtitle symlink (basename (dirname $src))
        $src
    end
end

function install_fisher
    title INSTALL FISHER
    if test ! -e $__fish_config_dir/functions/fisher.fish
        info "fisher not found on this system. installing..."
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
        and success "fisher installed"
        or fail fisher
    else
        success "fisher is already installed"
    end
end

function update_fisher
    title UPDATE FISHER
    fisher update
    and success "updated and installed plugins"
    or fail "failed to update and install plugins"
end

# Main function calls
greeting

# Check if --reset-git was passed when running the script, and 
# set the gitconfig managed state to false to re-init gitconfig
set -l options (fish_opt -s r -l reset-git --long-only)
argparse --ignore-unknown $options -- $argv
if set -q _flag_reset_git
    git config --global dotfiles.managed false
    and info "reset gitconfig..."
end

init_gitconfig
install_fisher
install_dotfiles
symlink_dotfiles
update_fisher
