#!/usr/bin/env bash
set -e

mkdir .config
git clone https://github.com/peterjcaulfield/nvim ~/.config/nvim
nvim +PlugClean +PlugInstall +qa
