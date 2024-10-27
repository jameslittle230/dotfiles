eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(nodenv init -)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

source /opt/homebrew/opt/spaceship/spaceship.zsh

alias vim="nvim"
alias cd="z"
alias c="code --new-window ."

alias gst="git status"
alias gaa="git add -A"
alias gc="git commit"
alias gcm="git commit main"
alias gco="git checkout"
alias gcob="git checkout -b"

kill_port() {
    if [ $# -eq 0 ]; then
        echo "Usage: kill_port <port_number>"
        return 1
    fi

    local port=$1
    local pid=$(lsof -ti tcp:$port)

    if [ -z "$pid" ]; then
        echo "No process found listening on port $port"
        return 1
    else
        echo "Killing process $pid listening on port $port"
        kill -9 $pid
        return 0
    fi
}

# pnpm
export PNPM_HOME="/Users/jil/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

