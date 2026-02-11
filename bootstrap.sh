#!/bin/bash -eu

DOTFILES_HOME=$HOME/.dotfiles

# Git
SRC_DIR=$DOTFILES_HOME/git
DEST_DIR=$HOME/.config/git

mkdir -p $DEST_DIR

for file in config ignore
do
  if [ -f $DEST_DIR/$file ]; then
    echo "$DEST_DIR/$file already exists, aborting to avoid overwriting."
  else
    ln -s $SRC_DIR/$file $DEST_DIR/$file
  fi
done

# Claude
SRC_DIR=$DOTFILES_HOME/claude
DEST_DIR=$HOME/.claude

mkdir -p $DEST_DIR

for file in settings.json
do
  if [ -f $DEST_DIR/$file ]; then
    echo "$DEST_DIR/$file already exists, aborting to avoid overwriting."
  else
    echo "installing $file to $DEST_DIR/"
    ln -s $SRC_DIR/$file $DEST_DIR/$file
  fi
done

# Ghostty
SRC_DIR=$DOTFILES_HOME/ghostty
DEST_DIR=$HOME/.config/ghostty

mkdir -p $DEST_DIR

for file in config
do
  if [ -f $DEST_DIR/$file ]; then
    echo "$DEST_DIR/$file already exists, aborting to avoid overwriting."
  else
    echo "installing $file to $DEST_DIR/"
    ln -s $SRC_DIR/$file $DEST_DIR/$file
  fi
done
