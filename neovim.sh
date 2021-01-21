#!/usr/bin/env bash

echo "Installing neovim configuration from remote"
mkdir .config
git clone https://github.com/peterjcaulfield/nvim ~/.config/nvim
nvim +PlugClean +PlugInstall +qa
