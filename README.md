# My dotfiles

### Features
* Fancy-ass terminal emulator with custom settings: [Alacritty](https://github.com/alacritty/alacritty)
* High end shell with customized prompt and theme ready to go: [fish](https://github.com/fish-shell/fish-shell)
   * Using plugin- and theme- manager: [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish)
* Terminal multiplexer with custom settings: [tmux](https://github.com/tmux/tmux/wiki)
* User-friendly command-line editor: [micro](https://github.com/zyedidia/micro)




## Setup
### Installing
Install script is currently only supported for manjaro/arch (pacman) and ubuntu/debian (apt-get) 

1. Start by cloning repository to home folder `git clone https://github.com/sebastas/dotfiles.git`
2. Read and run the `install-packages.sh` script with root privileges and specify distro. 
Necessary packages will be installed
3. Read and run the `install-symlinks.sh` script without sudo to set up the symlinks, change shell
to fish and install omf
4. Exit out of the terminal and open up Alacritty to see the wonderful terminal and shell
5. (Optional) Change theme in `micro` to "Darcula" to better match the rest of the layout


### Further config
Check out the files located in the repo `~/dotfiles` to better understand what they do.
The fish-prompt can be customized under `~/dotfiles/fish/functions/fish_prompt.fish`, custom keybindings 
can be set in `~/dotfiles/fish/functions/fish_user_key_bindings.fish`.

`.tmux.conf` is pretty basic with nothing fancy yet. This file can be further customized with specific
status-bar, themes and key-bindings.

`alacritty/alacritty.yml` contains a lot of configuration for the terminal emulator with possibilities
to specify custom escape sequences and various other settings.



## tmux shortcuts
* Prefix key: `Ctrl-b`
* Reload tmux config: prefix + `Ctrl-r`
* Split window horizontally - new vertical pane: `Alt-|`
* Split window vertically - new horizontal pane: `Alt--`
* Create new window [defualt]: prefix + `c`
* Switch to most recent used window: prefix + `Tab`
* Switch pane: `Shift-Alt-{ArrowKey}`
* Resize pane [default]: prefix + `Ctrl-{ArrowKey}`
* Swap/rotate panes [default]: prefix + `Ctrl-o`
* Session, window and pane overview/selector [default]: prefix + `w`
* Deattach from session [default]: prefix + `d` (Alacritty will automatically attach to 
session when started)
* Switch to most recent pane [default]: prefix + `o`
* Mouse mode is enabled with easier copy-pasting
* Showing ip address in status bar, might have som issues if device has multiple interfaces 
and addresses
* Only some default keybindings are listed, but none of them have been unbound and 
they all work
