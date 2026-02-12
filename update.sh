#!/bin/bash -eu

DOTFILES_HOME=$HOME/.dotfiles
STATUSLINE_REPO=$DOTFILES_HOME/repos/statusline
STATUSLINE_DEST=$HOME/.claude/statusline.py

if [ ! -d $STATUSLINE_REPO ]; then
  echo "Error: $STATUSLINE_REPO does not exist. Run install.sh first."
  exit 1
fi

echo "Updating statusline..."
git -C $STATUSLINE_REPO pull
cp $STATUSLINE_REPO/statusline.py $STATUSLINE_DEST
echo "statusline.py updated successfully."

# Everything Claude Code
ECC_REPO=$DOTFILES_HOME/repos/everything-claude-code
ECC_RULES_DEST=$DOTFILES_HOME/claude/rules

if [ ! -d $ECC_REPO ]; then
  echo "Error: $ECC_REPO does not exist. Run install.sh first."
  exit 1
fi

echo "Updating everything-claude-code..."
git -C $ECC_REPO pull
cp $ECC_REPO/rules/common/*.md $ECC_RULES_DEST/
echo "everything-claude-code rules updated successfully."
