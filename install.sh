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

# Claude directories (agents, skills, rules, commands)
for dir in agents skills rules commands
do
  if [ -e $DEST_DIR/$dir ] || [ -L $DEST_DIR/$dir ]; then
    echo "$DEST_DIR/$dir already exists, aborting to avoid overwriting."
  else
    echo "installing $dir to $DEST_DIR/"
    ln -s $SRC_DIR/$dir $DEST_DIR/$dir
  fi
done

# Homebrew (Brewfile)
if command -v brew &>/dev/null; then
  echo "Installing Homebrew packages from Brewfile..."
  brew bundle install --file=$DOTFILES_HOME/Brewfile
else
  echo "brew not found, skipping Brewfile install."
fi

# Statusline (usedhonda/statusline)
STATUSLINE_REPO=$DOTFILES_HOME/repos/statusline
STATUSLINE_DEST=$HOME/.claude/statusline.py

if [ ! -d $STATUSLINE_REPO ]; then
  echo "Cloning usedhonda/statusline..."
  mkdir -p $DOTFILES_HOME/repos
  git clone https://github.com/usedhonda/statusline.git $STATUSLINE_REPO
fi

if [ -f $STATUSLINE_DEST ]; then
  echo "$STATUSLINE_DEST already exists, aborting to avoid overwriting."
else
  echo "installing statusline.py to $HOME/.claude/"
  cp $STATUSLINE_REPO/statusline.py $STATUSLINE_DEST
fi

# Everything Claude Code (affaan-m/everything-claude-code)
ECC_REPO=$DOTFILES_HOME/repos/everything-claude-code
ECC_RULES_DEST=$DOTFILES_HOME/claude/rules

if [ ! -d $ECC_REPO ]; then
  echo "Cloning affaan-m/everything-claude-code..."
  mkdir -p $DOTFILES_HOME/repos
  git clone https://github.com/affaan-m/everything-claude-code.git $ECC_REPO
fi

# Copy common rules (plugin system cannot distribute rules)
if [ -d $ECC_REPO/rules/common ]; then
  for file in $ECC_REPO/rules/common/*.md
  do
    filename=$(basename $file)
    if [ -f $ECC_RULES_DEST/$filename ]; then
      echo "$ECC_RULES_DEST/$filename already exists, aborting to avoid overwriting."
    else
      echo "installing $filename to $ECC_RULES_DEST/"
      cp $file $ECC_RULES_DEST/$filename
    fi
  done
fi
