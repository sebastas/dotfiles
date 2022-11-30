if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting "" # disable greeting
    fish_add_path $HOME/.local/bin # add to PATH for bat and fd
end
