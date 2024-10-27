eval (/opt/homebrew/bin/brew shellenv)
status --is-interactive; and nodenv init - fish | source
zoxide init fish | source
starship init fish | source
fzf --fish | source
source ~/.iterm2_shell_integration.fish

set -U fish_greeting "Welcome to Fish. 🐟"

abbr -a vim nvim
abbr -a cd z
abbr -a c code --new-window .

function mux
  set -l name main
  if test (count $argv) -gt 0
    set name $argv[1]
  end
  tmux -CC new -A -s $name
end

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end

abbr --add dotdot --regex '^\.\.+$' --function multicd

function kill_port
    if test (count $argv) -eq 0
        echo "Usage: kill_port <port_number>"
        return 1
    end

    set port $argv[1]
    set pid (lsof -ti tcp:$port)

    if test -z "$pid"
        echo "No process found listening on port $port"
        return 1
    else
        echo "Killing process $pid listening on port $port"
        kill -9 $pid
        return 0
    end
end