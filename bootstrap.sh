#!/bin/bash -eu

DOTFILES_HOME=$HOME/.dotfiles

# Git
mkdir -p $HOME/.config/git

for file in config ignore
do
  if [ -f $HOME/.config/git/$file ]; then
    echo "$HOME/.config/git/$file already exists, aborting to avoid overwriting."
  else
    ln -s $DOTFILES_HOME/git/$file $HOME/.config/git/$file
  fi
done

if [ -f $HOME/.gitconfig ]; then
  echo "$HOME/.gitconfig already exists, aborting to avoid overwriting."
else
  echo "installing .gitconfig to $HOME/ .gitconfig"
  ln -s $HOME/.config/git/config $HOME/.gitconfig
fi

# Claude
mkdir -p $HOME/.config/claude

for file in settings.json statusline.sh
do
  if [ -f $HOME/.claude/$file ]; then
    echo "$HOME/.claude/$file already exists, aborting to avoid overwriting."
  else
    eecho "installing $file to $HOME/.claude/"
    ln -s $DOTFILES_HOME/claude/$file $HOME/.claude/$file
  fi
done

# Ghostty
mkdir -p $HOME/.config/ghostty
ln -s $DOTFILES_HOME/ghostty/config $HOME/.config/ghostty/config
