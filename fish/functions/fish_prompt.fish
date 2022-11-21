# Source git functions
source $__fish_config_dir/functions/git_functions.fish

function fish_prompt
    set -l last_command_status $status
    set -l cwd

    if test "$theme_short_path" = yes
        set cwd (basename (prompt_pwd))
    else
        set cwd (prompt_pwd)
    end

    set -l user "$USER"
    set -l host "$hostname"
    set -l ahead "↑"
    set -l behind "↓"
    set -l diverged "⥄ "
    set -l dirty "⨯"
    set -l none "◦"

    set -l normal_color (set_color normal) # //TODO rename normal_color to normal
    set -l green (set_color green)
    set -l red (set_color red)
    set -l cyan (set_color cyan)
    set -l blue (set_color blue)
    set -l yellow (set_color yellow)

    if test $last_command_status -eq 0
        echo -n -s $green $user $normal_color " on " $cyan $host
    else
        echo -n -s $red $user $normal_color " on " $cyan $host
    end

    if git_is_repo
        if test "$theme_short_path" = yes
            set root_folder (command git rev-parse --show-toplevel 2> /dev/null)
            set parent_root_folder (dirname $root_folder)
            set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
        end

        echo -n -s " " $yellow $cwd $normal_color
        echo -n -s " on " $green (git_branch_name) $normal_color " "

        if git_is_touched
            echo -n -s $red $dirty $normal_color
        else
            echo -n -s (git_ahead $ahead $behind $diverged $none)
        end
    else
        echo -n -s " " $yellow $cwd $normal_color
    end

    echo -n -s " "
end
