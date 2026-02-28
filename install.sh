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

# Lazygit
SRC_DIR=$DOTFILES_HOME/lazygit
DEST_DIR=$HOME/.config/lazygit

mkdir -p $DEST_DIR

for file in config.yml
do
  if [ -f $DEST_DIR/$file ]; then
    echo "$DEST_DIR/$file already exists, aborting to avoid overwriting."
  else
    echo "installing $file to $DEST_DIR/"
    ln -s $SRC_DIR/$file $DEST_DIR/$file
  fi
done

# Starship
SRC_DIR=$DOTFILES_HOME/starship
DEST=$HOME/.config/starship.toml

if [ -f $DEST ]; then
  echo "$DEST already exists, aborting to avoid overwriting."
else
  echo "installing starship.toml to ~/.config/"
  ln -s $SRC_DIR/starship.toml $DEST
fi

# Neovim (LazyVim)
SRC_DIR=$DOTFILES_HOME/nvim
DEST=$HOME/.config/nvim

if [ -e $DEST ] || [ -L $DEST ]; then
  echo "$DEST already exists, aborting to avoid overwriting."
else
  echo "installing nvim config to ~/.config/nvim"
  ln -s $SRC_DIR $DEST
fi

# Claude
SRC_DIR=$DOTFILES_HOME/claude
DEST_DIR=$HOME/.claude

mkdir -p $DEST_DIR

for file in settings.json CLAUDE.md
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

# Claude Plugins Official (anthropics/claude-plugins-official)
CPO_REPO=$DOTFILES_HOME/repos/claude-plugins-official
CPO_PLUGINS=$CPO_REPO/plugins

if [ ! -d $CPO_REPO ]; then
  echo "Cloning anthropics/claude-plugins-official..."
  mkdir -p $DOTFILES_HOME/repos
  git clone https://github.com/anthropics/claude-plugins-official.git $CPO_REPO
fi

# Superpowers (obra/superpowers) — external plugin referenced by CPO
SP_REPO=$DOTFILES_HOME/repos/superpowers

if [ ! -d $SP_REPO ]; then
  echo "Cloning obra/superpowers..."
  mkdir -p $DOTFILES_HOME/repos
  git clone https://github.com/obra/superpowers.git $SP_REPO
fi

# Helper: copy agent with plugin prefix to avoid name collisions
# Usage: copy_agent <source_file> <plugin_name>
copy_agent() {
  local src=$1
  local plugin=$2
  local agent_name=$(basename $src)
  local dest=$DOTFILES_HOME/claude/agents/${plugin}--${agent_name}
  if [ -f $dest ]; then
    echo "$dest already exists, aborting to avoid overwriting."
  else
    echo "installing ${plugin}--${agent_name} to claude/agents/"
    cp $src $dest
  fi
}

# Helper: copy command (no prefix needed — no conflicts)
# Usage: copy_command <source_file>
copy_command() {
  local src=$1
  local filename=$(basename $src)
  local dest=$DOTFILES_HOME/claude/commands/$filename
  if [ -f $dest ]; then
    echo "$dest already exists, aborting to avoid overwriting."
  else
    echo "installing $filename to claude/commands/"
    cp $src $dest
  fi
}

# Helper: copy skill directory
# Usage: copy_skill <source_dir>
copy_skill() {
  local src=$1
  local dirname=$(basename $src)
  local dest=$DOTFILES_HOME/claude/skills/$dirname
  if [ -d $dest ]; then
    echo "$dest already exists, aborting to avoid overwriting."
  else
    echo "installing skill $dirname to claude/skills/"
    cp -r $src $dest
  fi
}

# CPO agents (prefixed with plugin name)
copy_agent $CPO_PLUGINS/code-simplifier/agents/code-simplifier.md code-simplifier
copy_agent $CPO_PLUGINS/pr-review-toolkit/agents/code-reviewer.md pr-review-toolkit
copy_agent $CPO_PLUGINS/pr-review-toolkit/agents/code-simplifier.md pr-review-toolkit
copy_agent $CPO_PLUGINS/pr-review-toolkit/agents/comment-analyzer.md pr-review-toolkit
copy_agent $CPO_PLUGINS/pr-review-toolkit/agents/pr-test-analyzer.md pr-review-toolkit
copy_agent $CPO_PLUGINS/pr-review-toolkit/agents/silent-failure-hunter.md pr-review-toolkit
copy_agent $CPO_PLUGINS/pr-review-toolkit/agents/type-design-analyzer.md pr-review-toolkit
copy_agent $CPO_PLUGINS/feature-dev/agents/code-architect.md feature-dev
copy_agent $CPO_PLUGINS/feature-dev/agents/code-explorer.md feature-dev
copy_agent $CPO_PLUGINS/feature-dev/agents/code-reviewer.md feature-dev

# Superpowers agent (prefixed)
copy_agent $SP_REPO/agents/code-reviewer.md superpowers

# CPO commands
copy_command $CPO_PLUGINS/commit-commands/commands/clean_gone.md
copy_command $CPO_PLUGINS/commit-commands/commands/commit-push-pr.md
copy_command $CPO_PLUGINS/commit-commands/commands/commit.md
copy_command $CPO_PLUGINS/code-review/commands/code-review.md
copy_command $CPO_PLUGINS/pr-review-toolkit/commands/review-pr.md
copy_command $CPO_PLUGINS/claude-md-management/commands/revise-claude-md.md
copy_command $CPO_PLUGINS/feature-dev/commands/feature-dev.md

# Superpowers commands
copy_command $SP_REPO/commands/brainstorm.md
copy_command $SP_REPO/commands/execute-plan.md
copy_command $SP_REPO/commands/write-plan.md

# CPO skills
copy_skill $CPO_PLUGINS/claude-code-setup/skills/claude-automation-recommender
copy_skill $CPO_PLUGINS/claude-md-management/skills/claude-md-improver

# Superpowers skills (14 directories)
for skill_dir in $SP_REPO/skills/*/
do
  copy_skill $skill_dir
done

# CPO hooks
HOOKS_DEST=$DOTFILES_HOME/claude/hooks

# security-guidance hook
if [ -f $HOOKS_DEST/security_reminder_hook.py ]; then
  echo "$HOOKS_DEST/security_reminder_hook.py already exists, aborting to avoid overwriting."
else
  echo "installing security_reminder_hook.py to claude/hooks/"
  cp $CPO_PLUGINS/security-guidance/hooks/security_reminder_hook.py $HOOKS_DEST/security_reminder_hook.py
fi
