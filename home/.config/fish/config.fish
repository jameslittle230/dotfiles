eval (/opt/homebrew/bin/brew shellenv)
status --is-interactive; and nodenv init - fish | source
zoxide init fish | source
starship init fish | source
fzf --fish | source
source ~/.iterm2_shell_integration.fish

set -U fish_greeting "Welcome to Fish. 🐟"

abbr -a vim nvim
abbr -a cd z
abbr -a ls eza -AlUhb --time-style iso
abbr -a c code --new-window .
abbr -a v nvim .
abbr -a g git

abbr -a gco git checkout
abbr -a gcob git checkout -b
abbr -a gmaster git fetch origin master:master

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

function gch
  set branch (git for-each-ref --format='%(refname:short) %(committerdate:relative)' --sort=-committerdate refs/heads | fzf --prompt="Select local branch: " | awk '{print $1}')
  if test -n "$branch"
    git checkout $branch
  else
    echo "No branch selected."
  end
end

function rename-branch
  if test (count $argv) -eq 1
    set old_branch (git rev-parse --abbrev-ref HEAD)
    set new_branch $argv[1]
  else if test (count $argv) -eq 2
    set old_branch $argv[1]
    set new_branch $argv[2]
  else
    echo "Usage: rename-branch <new-branch-name>"
    echo "   or: rename-branch <old-branch-name> <new-branch-name>"
    return 1
  end

  set current_branch (git rev-parse --abbrev-ref HEAD)
  if test "$current_branch" != "$old_branch"
    git checkout "$old_branch"
  end

  git branch -m "$new_branch"

  git push origin -u "$new_branch"
  git push origin --delete "$old_branch"

  echo "Branch '$old_branch' has been renamed to '$new_branch' locally and remotely."
end

test -f ~/.config/fish/config.local.fish && source ~/.config/fish/config.local.fish
