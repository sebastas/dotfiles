# Open file explorer
function open_explorer
    set uname (git config --get dotfiles.uname)
    if test $uname = Linux
        if test (systemd-detect-virt) = wsl
            # Windows File Explorer
            explorer.exe .
        else
            # Running Linux - File explorer might vary
            xdg-open .
        end
    else if test $uname = Darwin
        # Running Mac - opening Finder
        open .
    else
        echo "Unable to determine OS and File Explorer"
    end
end
