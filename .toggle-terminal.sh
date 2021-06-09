#!/bin/bash
active=$(xdotool getactivewindow getwindowname)
active=${active,,}
if [[ $active = "alacritty" ]]; then
    xdotool getactivewindow windowminimize
else
    xdotool search --name --desktop 0 alacritty windowactivate || alacritty
fi
