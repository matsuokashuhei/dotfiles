#!/bin/bash -eu

DOTFILES_HOME=$HOME/.dotfiles
STATUSLINE_REPO=$DOTFILES_HOME/repos/statusline
STATUSLINE_DEST=$HOME/.claude/statusline.py

if [ ! -d $STATUSLINE_REPO ]; then
  echo "Error: $STATUSLINE_REPO does not exist. Run bootstrap.sh first."
  exit 1
fi

echo "Updating statusline..."
git -C $STATUSLINE_REPO pull
cp $STATUSLINE_REPO/statusline.py $STATUSLINE_DEST
echo "statusline.py updated successfully."
