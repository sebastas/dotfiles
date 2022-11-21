function info -d 'displays argument as information'
    echo [(set_color --bold) ' !! ' (set_color normal)] $argv
end

function user -d 'displays argument as a prompt for input'
    echo [(set_color yellow) ' ?? ' (set_color normal)] $argv
end

function success -d 'displays argument as successful'
    echo [(set_color green) ' OK ' (set_color normal)] $argv
end

function fail -d 'displays argument as a warning and exits'
    echo [(set_color red) FAIL (set_color normal)] $argv
    exit 1
end

function title -d 'displays argument as a title'
    echo (set_color cyan) '========== ' $argv ' ==========' (set_color normal)
end

function subtitle -d 'displays argument as a subtitle'
    echo (set_color magenta) '===== ' $argv ' =====' (set_color normal)
end
