# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Installation and Setup

This is a personal dotfiles repository that symlinks configuration files from `home/` to `~/` and installs utility scripts from `bin/` to `/usr/local/bin/`.

**Setup command**: `./linker.sh`

The linker script handles:
- Installing Homebrew packages from `home/.homebrew_packages_to_install`
- Installing Ruby via asdf and gems from `home/.ruby_gems_to_install` 
- Symlinking all dotfiles from `home/.*` to `~/.*`
- Symlinking scripts from `bin/` to `/usr/local/bin/`
- Setting macOS defaults for VS Code key repeat behavior

## Architecture

### Core Structure
- `home/` - Contains all dotfiles that get symlinked to `~/`
- `bin/` - Utility scripts symlinked to `/usr/local/bin/`
- `linker.sh` - Main installation script with prerequisite checks

### Key Configuration Areas
- **Shell**: zsh with oh-my-zsh and powerlevel10k theme (`.zshrc`, `.p10k.zsh`)
- **Git**: Custom aliases and configuration (`.gitconfig`, `.shell_scripts/git_aliases.sh`)
- **Vim**: Full vim setup with bundles in `.vim/bundle/`
- **tmux**: Cross-platform config with separate Mac/Linux files (`.tmux.conf`, `.tmux-*.conf`)
- **Development Tools**: asdf for version management, custom shell aliases in `.shell_scripts/`

### Prerequisites
- Homebrew installed
- oh-my-zsh installed
- `/usr/local/bin` exists and is writable

### Git Subtree Management
Use git subtree commands for vim plugins:
```bash
git remote add -f plugin-name https://repo-url
git subtree add --prefix .vim/bundle/plugin-name plugin-name master --squash
git subtree pull --prefix .vim/bundle/plugin-name plugin-name master --squash
```