#!/usr/bin/env bash
set -e

# Neovim
sh ./neovim.sh

# Oh My Zsh
sh ./oh-my-zsh.sh \
    -t https://github.com/denysdovhan/spaceship-prompt \
    -a 'SPACESHIP_PROMPT_ADD_NEWLINE="false"' \
    -a 'SPACESHIP_PROMPT_SEPARATE_LINE="false"' \
    -p git

# Dotfiles
sh ./dotfiles.sh
