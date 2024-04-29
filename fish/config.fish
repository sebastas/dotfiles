if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting "" # disable greeting
    fish_add_path $HOME/.local/bin # add to PATH for bat and fd

    # fzf-fish config
    set fzf_fd_opts --hidden --exclude={.git,.vscode,.vscode-server,.idea}
    set -gx EDITOR micro
    set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
    set -gx fzf_preview_dir_cmd eza --all --icons --oneline --tree --group-directories-first --git-ignore --color=always

    # LS_COLORS (using vivid - https://github.com/sharkdp/vivid)
    set -gx LS_COLORS (vivid generate catppuccin-mocha)

    # Set micro truecolor
    set -gx MICRO_TRUECOLOR 1

    # kube toggle (Ctrl+Alt+K)
    bind \e\ck 'test "$__kube_ps_enabled" = 1; set -U __kube_ps_enabled $status; commandline -f repaint'

    # eza config
    function la
        command eza --long --all --git --icons --group-directories-first --group --header --color=always $argv
    end
    function lt
        command eza --long --all --git --icons --group-directories-first --group --header --tree --git-ignore $argv
    end
    funcsave --quiet la lt
end
