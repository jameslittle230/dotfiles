#!/bin/bash
set -euo pipefail

brew install bat
brew install doggo
brew install eza
brew install entr
brew install fd
brew install ffmpeg
brew install fish
brew install fzf
brew install gh
brew install git-delta
brew install imagemagick
brew install jq
brew install lazygit
brew install ncdu
brew install neovim  # 0.12, used as nvim12

# Install neovim 0.11 as the default nvim
NVIM11_VERSION="0.11.7"
NVIM11_ARCH="$(uname -m)"
mkdir -p ~/.local/nvim11
curl -fL "https://github.com/neovim/neovim/releases/download/v${NVIM11_VERSION}/nvim-macos-${NVIM11_ARCH}.tar.gz" \
  | tar xz -C ~/.local/nvim11 --strip-components=1
brew install nodenv
brew install ripgrep
brew install starship
brew install tailscale
brew install tmux
brew install tree-sitter
brew install tree-sitter-cli
brew install typst
brew install wget
brew install yt-dlp
brew install zoxide

brew install --cask nikitabobko/tap/aerospace
brew install FelixKratz/formulae/borders
