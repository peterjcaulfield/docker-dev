#!/usr/bin/env bash
echo
echo "Installing neovim configuration from remote"
echo
mkdir .config
git clone https://github.com/peterjcaulfield/nvim ~/.config/nvim
nvim +PlugClean +PlugInstall +qa
