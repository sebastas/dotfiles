#!/usr/bin/env fish

set DOTFILES_ROOT (git rev-parse --show-toplevel)
set CURRENT_DIR (dirname (status --current-file))

source $DOTFILES_ROOT/fish/functions/outputs.fish
source $DOTFILES_ROOT/fish/functions/symlink_backup.fish

set distro (git config --get dotfiles.distro)

# Installs azure-cli for ubuntu and debian systems
function install_apt
    if test ! (command -v az)
        info "installing for [$distro]"
        curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
        and success "installed azure-cli"
    else
        success "azure-cli is already installed... run 'az upgrade' to update"
        
        # Uncomment to update azure-cli with this script. Prefer to do it manually?
        # az upgrade
        # and success "azure-cli updated"
    end
end


# //TODO: WIP for RHEL, CentOS, Rocky, Alma (8 and 9) - not tested yet
# info: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=dnf
# function install_dnf
#     sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
#     and info "import Microsoft repo key"
#     set distro_version (grep "^VERSION_ID=" /etc/os-release | sed -E 's/VERSION_ID=(.*)/\1/')
#     switch $distro_version
#         case "9"
#             sudo dnf install -y https://packages.microsoft.com/config/rhel/9.0/packages-microsoft-prod.rpm
#         case '8'
#             sudo dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
#     end
#     sudo dnf install azure-cli -y
#     and success "azure-cli installed"
# end

# //TODO not tested yet!
# Installs azure-cli on fedora systems 
# function install_fedora
#     sudo dnf install azure-cli -y
# end

switch $distro
    case ubuntu debian pop
        install_apt
    case '*'
        info "unable to install azure-cli for [$distro]"
end
