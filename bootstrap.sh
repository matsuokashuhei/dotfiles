#!/bin/bash -eu

DOTFILES_HOME=$HOME/.dotfiles

# Git
mkdir -p $HOME/.config/git

for file in config ignore
do
  ln -s $DOTFILES_HOME/git/$file $HOME/.config/git/$file
done

ln -s $HOME/.config/git/config $HOME/.gitconfig
