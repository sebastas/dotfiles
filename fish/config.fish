if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting "" # disable greeting
    fish_add_path $HOME/.local/bin # add to PATH for bat and fd

    # fzf-fish config
    set fzf_fd_opts --hidden --exclude={.git,.vscode,.vscode-server,.idea}
    set -gx EDITOR "micro"
    set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

    # LS_COLORS (using vivid - https://github.com/sharkdp/vivid)
    set -gx LS_COLORS (vivid generate nord)
end
