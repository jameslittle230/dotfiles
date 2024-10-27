#!/bin/bash
set -euo pipefail

# Copy dotfiles to home directory
cp -Rf ./home/ ~

# Set iTerm2 
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$(pwd)/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

exec $SHELL
