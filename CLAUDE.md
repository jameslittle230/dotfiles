# Dotfiles

This repo contains personal macOS dotfiles.

## How it works

Files in `home/` mirror the home directory structure. Running `~/.init.sh` syncs everything in `home/` to the actual home directory (`~/`).

## Editing configs

When asked to update any config (vim, fish, git, etc.), edit the corresponding file under `home/` in this repo. Changes do **not** take effect until the user manually runs `~/.init.sh`.

During active editing sessions, `dev.sh` can be run instead — it watches git-tracked files and reruns `init.sh` automatically on changes.

## Config file locations

| Tool | File |
|------|------|
| Fish shell | `home/.config/fish/config.fish` |
| Neovim | `home/.config/nvim/init.lua` (shared), `home/.config/nvim/lua/platform.lua` (all laptops) |
| Starship prompt | `home/.config/starship.toml` |
| Git | `home/.gitconfig`, `home/.gitconfig.user`, `home/.gitignore`, `home/.git-commit-template` |
| AeroSpace (window manager) | `home/.aerospace.toml` |
| Claude Code | `home/.claude/settings.json` |
| iTerm2 | `iterm2/com.googlecode.iterm2.plist` (not in `home/` — synced separately by `init.sh` via `defaults write`) |

## Machine-local overrides

Fish shell sources `~/.config/fish/config.local.fish` if it exists. Machine-specific Fish config (env vars, paths, secrets) belongs there — it is not tracked in this repo.

Neovim's `init.lua` is shared with another dotfiles repo, so it must stay generic; put laptop-only Neovim config in `lua/platform.lua`. Neovim loads `home/.config/nvim/lua/local.lua` last if it exists. It is gitignored, so machine-specific Neovim config belongs there.

## Adding new tools

If asked to add a new CLI tool, also add it to `software.sh`, which installs packages via Homebrew.
