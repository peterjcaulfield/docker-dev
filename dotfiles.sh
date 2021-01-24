#!/usr/bin/env bash
echo
echo "Installing dotfiles from remote"
echo

git clone https://github.com/peterjcaulfield/dotfiles.git

rm -rf ./dotfiles/.git

cp -rT ./dotfiles .

rm -rf ./dotfiles
