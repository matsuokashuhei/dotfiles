#!/bin/bash -eu

DOTFILES_HOME="$HOME/.dotfiles"

# --- Helper functions ---

# Usage: link_files <src_dir> <dest_dir> <file1> [file2 ...]
link_files() {
  local src_dir="$1"; shift
  local dest_dir="$1"; shift
  mkdir -p "$dest_dir"
  for file in "$@"; do
    if [ -e "$dest_dir/$file" ] || [ -L "$dest_dir/$file" ]; then
      echo "$dest_dir/$file already exists, aborting to avoid overwriting."
    else
      echo "installing $file to $dest_dir/"
      ln -s "$src_dir/$file" "$dest_dir/$file"
    fi
  done
}

# Usage: link_dotfiles <src_dir> <dest_dir> <file1> [file2 ...]
# Same as link_files but prepends "." to destination filename
link_dotfiles() {
  local src_dir="$1"; shift
  local dest_dir="$1"; shift
  for file in "$@"; do
    if [ -e "$dest_dir/.$file" ] || [ -L "$dest_dir/.$file" ]; then
      echo "$dest_dir/.$file already exists, aborting to avoid overwriting."
    else
      echo "installing .$file to $dest_dir/"
      ln -s "$src_dir/$file" "$dest_dir/.$file"
    fi
  done
}

# Usage: link_single <src> <dest>
link_single() {
  local src="$1"
  local dest="$2"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "$dest already exists, aborting to avoid overwriting."
  else
    echo "installing $(basename "$src") to $(dirname "$dest")/"
    ln -s "$src" "$dest"
  fi
}

# Usage: copy_prefixed <src_file> <plugin_name> <dest_dir>
copy_prefixed() {
  local src="$1"
  local plugin="$2"
  local dest_dir="$3"
  local name
  name=$(basename "$src")
  local dest="$dest_dir/${plugin}--${name}"
  if [ -f "$dest" ]; then
    echo "$dest already exists, aborting to avoid overwriting."
  else
    echo "installing ${plugin}--${name} to $dest_dir/"
    cp "$src" "$dest"
  fi
}

# Usage: copy_skill <source_dir>
copy_skill() {
  local src="$1"
  local dirname
  dirname=$(basename "$src")
  local dest="$DOTFILES_HOME/claude/skills/$dirname"
  if [ -d "$dest" ]; then
    echo "$dest already exists, aborting to avoid overwriting."
  else
    echo "installing skill $dirname to claude/skills/"
    cp -r "$src" "$dest"
  fi
}

# Usage: clone_repo <url> <dest_dir>
clone_repo() {
  local url="$1"
  local dest="$2"
  if [ ! -d "$dest" ]; then
    echo "Cloning $url..."
    git clone "$url" "$dest"
  fi
}

# --- Symlinks ---

# Git
link_files "$DOTFILES_HOME/git" "$HOME/.config/git" config ignore

# Zsh
link_dotfiles "$DOTFILES_HOME/zsh" "$HOME" zshrc zprofile

# Ghostty
link_files "$DOTFILES_HOME/ghostty" "$HOME/.config/ghostty" config

# Lazygit
link_files "$DOTFILES_HOME/lazygit" "$HOME/.config/lazygit" config.yml

# Starship
link_single "$DOTFILES_HOME/starship/starship.toml" "$HOME/.config/starship.toml"

# Zed
link_files "$DOTFILES_HOME/zed" "$HOME/.config/zed" settings.json

# Neovim (LazyVim)
link_single "$DOTFILES_HOME/nvim" "$HOME/.config/nvim"

# Claude
link_files "$DOTFILES_HOME/claude" "$HOME/.claude" settings.json CLAUDE.md

# Claude directories (agents, skills, rules, commands)
for dir in agents skills rules commands; do
  link_single "$DOTFILES_HOME/claude/$dir" "$HOME/.claude/$dir"
done

# Homebrew (Brewfile)
if command -v brew &>/dev/null; then
  echo "Installing Homebrew packages from Brewfile..."
  brew bundle install --file="$DOTFILES_HOME/Brewfile"
else
  echo "brew not found, skipping Brewfile install."
fi

# --- External repos ---

mkdir -p "$DOTFILES_HOME/repos"

clone_repo https://github.com/usedhonda/statusline.git "$DOTFILES_HOME/repos/statusline"
clone_repo https://github.com/affaan-m/everything-claude-code.git "$DOTFILES_HOME/repos/everything-claude-code"
clone_repo https://github.com/anthropics/claude-plugins-official.git "$DOTFILES_HOME/repos/claude-plugins-official"
clone_repo https://github.com/obra/superpowers.git "$DOTFILES_HOME/repos/superpowers"

# Statusline
STATUSLINE_DEST="$HOME/.claude/statusline.py"
if [ -f "$STATUSLINE_DEST" ]; then
  echo "$STATUSLINE_DEST already exists, aborting to avoid overwriting."
else
  echo "installing statusline.py to $HOME/.claude/"
  cp "$DOTFILES_HOME/repos/statusline/statusline.py" "$STATUSLINE_DEST"
fi

# Everything Claude Code rules
ECC_REPO="$DOTFILES_HOME/repos/everything-claude-code"
if [ -d "$ECC_REPO/rules/common" ]; then
  for file in "$ECC_REPO/rules/common"/*.md; do
    copy_prefixed "$file" everything-claude-code "$DOTFILES_HOME/claude/rules"
  done
fi

# Claude Plugins Official + Superpowers
CPO_PLUGINS="$DOTFILES_HOME/repos/claude-plugins-official/plugins"
SP_REPO="$DOTFILES_HOME/repos/superpowers"

# CPO agents
copy_prefixed "$CPO_PLUGINS/code-simplifier/agents/code-simplifier.md" code-simplifier "$DOTFILES_HOME/claude/agents"
copy_prefixed "$CPO_PLUGINS/pr-review-toolkit/agents/code-reviewer.md" pr-review-toolkit "$DOTFILES_HOME/claude/agents"
copy_prefixed "$CPO_PLUGINS/pr-review-toolkit/agents/code-simplifier.md" pr-review-toolkit "$DOTFILES_HOME/claude/agents"
copy_prefixed "$CPO_PLUGINS/pr-review-toolkit/agents/comment-analyzer.md" pr-review-toolkit "$DOTFILES_HOME/claude/agents"
copy_prefixed "$CPO_PLUGINS/pr-review-toolkit/agents/pr-test-analyzer.md" pr-review-toolkit "$DOTFILES_HOME/claude/agents"
copy_prefixed "$CPO_PLUGINS/pr-review-toolkit/agents/silent-failure-hunter.md" pr-review-toolkit "$DOTFILES_HOME/claude/agents"
copy_prefixed "$CPO_PLUGINS/pr-review-toolkit/agents/type-design-analyzer.md" pr-review-toolkit "$DOTFILES_HOME/claude/agents"
copy_prefixed "$CPO_PLUGINS/feature-dev/agents/code-architect.md" feature-dev "$DOTFILES_HOME/claude/agents"
copy_prefixed "$CPO_PLUGINS/feature-dev/agents/code-explorer.md" feature-dev "$DOTFILES_HOME/claude/agents"
copy_prefixed "$CPO_PLUGINS/feature-dev/agents/code-reviewer.md" feature-dev "$DOTFILES_HOME/claude/agents"

# Superpowers agent
copy_prefixed "$SP_REPO/agents/code-reviewer.md" superpowers "$DOTFILES_HOME/claude/agents"

# CPO commands
copy_prefixed "$CPO_PLUGINS/commit-commands/commands/clean_gone.md" commit-commands "$DOTFILES_HOME/claude/commands"
copy_prefixed "$CPO_PLUGINS/commit-commands/commands/commit-push-pr.md" commit-commands "$DOTFILES_HOME/claude/commands"
copy_prefixed "$CPO_PLUGINS/commit-commands/commands/commit.md" commit-commands "$DOTFILES_HOME/claude/commands"
copy_prefixed "$CPO_PLUGINS/code-review/commands/code-review.md" code-review "$DOTFILES_HOME/claude/commands"
copy_prefixed "$CPO_PLUGINS/pr-review-toolkit/commands/review-pr.md" pr-review-toolkit "$DOTFILES_HOME/claude/commands"
copy_prefixed "$CPO_PLUGINS/claude-md-management/commands/revise-claude-md.md" claude-md-management "$DOTFILES_HOME/claude/commands"
copy_prefixed "$CPO_PLUGINS/feature-dev/commands/feature-dev.md" feature-dev "$DOTFILES_HOME/claude/commands"

# Superpowers commands
copy_prefixed "$SP_REPO/commands/brainstorm.md" superpowers "$DOTFILES_HOME/claude/commands"
copy_prefixed "$SP_REPO/commands/execute-plan.md" superpowers "$DOTFILES_HOME/claude/commands"
copy_prefixed "$SP_REPO/commands/write-plan.md" superpowers "$DOTFILES_HOME/claude/commands"

# CPO skills
copy_skill "$CPO_PLUGINS/claude-code-setup/skills/claude-automation-recommender"
copy_skill "$CPO_PLUGINS/claude-md-management/skills/claude-md-improver"

# Superpowers skills
for skill_dir in "$SP_REPO/skills"/*/; do
  copy_skill "$skill_dir"
done

# CPO hooks
HOOKS_DEST="$DOTFILES_HOME/claude/hooks"
if [ -f "$HOOKS_DEST/security_reminder_hook.py" ]; then
  echo "$HOOKS_DEST/security_reminder_hook.py already exists, aborting to avoid overwriting."
else
  echo "installing security_reminder_hook.py to claude/hooks/"
  cp "$CPO_PLUGINS/security-guidance/hooks/security_reminder_hook.py" "$HOOKS_DEST/security_reminder_hook.py"
fi
