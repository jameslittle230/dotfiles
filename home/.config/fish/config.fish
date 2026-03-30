eval (/opt/homebrew/bin/brew shellenv)
status --is-interactive; and nodenv init - fish | source
zoxide init fish | source
starship init fish | source
fzf --fish | source
source ~/.iterm2_shell_integration.fish

fish_add_path $HOME/.local/bin

set -U fish_greeting "Welcome to Fish. 🐟"

abbr -a vim nvim
abbr -a cd z
abbr -a v nvim .
abbr -a g git

abbr -a gco git checkout
abbr -a gcob git checkout -b
abbr -a gmaster git fetch origin master:master

function ls
  eza --long --changed --header --binary --time-style long-iso $argv
end

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

set -g fish_color_autosuggestion 6272a4
set -g fish_color_cancel ff5555 --reverse
set -g fish_color_command 8be9fd
set -g fish_color_comment 6272a4
set -g fish_color_cwd 50fa7b
set -g fish_color_cwd_root red
set -g fish_color_end ffb86c
set -g fish_color_error ff5555
set -g fish_color_escape ff79c6
set -g fish_color_history_current --bold
set -g fish_color_host bd93f9
set -g fish_color_host_remote bd93f9
set -g fish_color_keyword ff79c6
set -g fish_color_normal f8f8f2
set -g fish_color_operator 50fa7b
set -g fish_color_option ffb86c
set -g fish_color_param bd93f9
set -g fish_color_quote f1fa8c
set -g fish_color_redirection f8f8f2
set -g fish_color_search_match --bold --background=44475a
set -g fish_color_selection --bold --background=44475a
set -g fish_color_status ff5555
set -g fish_color_user 8be9fd
set -g fish_color_valid_path --underline=single
set -g fish_pager_color_background
set -g fish_pager_color_completion f8f8f2
set -g fish_pager_color_description 6272a4
set -g fish_pager_color_prefix 8be9fd
set -g fish_pager_color_progress 6272a4
set -g fish_pager_color_secondary_background
set -g fish_pager_color_secondary_completion
set -g fish_pager_color_secondary_description
set -g fish_pager_color_secondary_prefix
set -g fish_pager_color_selected_background --background=44475a
set -g fish_pager_color_selected_completion f8f8f2
set -g fish_pager_color_selected_description 6272a4
set -g fish_pager_color_selected_prefix 8be9fd

test -f ~/.config/fish/config.local.fish && source ~/.config/fish/config.local.fish
