# dotfiles

Dotfiles repository for macOS development environment. Configuration files are managed via symlinks.

## Repository Structure

```
├── install.sh            # Install script (creates symlinks & sets up statusline)
├── update.sh             # Statusline update script
├── bash/bash_profile     # Bash shell config (legacy, not handled by install.sh)
├── claude/
│   ├── settings.json     # Claude Code CLI settings
│   ├── agents/           # Custom agent definitions (9 agents)
│   ├── commands/         # Slash command definitions (9 commands)
│   ├── rules/            # Coding rules & guidelines (8 rules)
│   └── skills/           # Skill definitions (5 files + 4 subdirectories)
├── ghostty/config        # Ghostty terminal config
├── git/config            # Git user settings & aliases
└── git/ignore            # Global gitignore (excludes macOS-specific files)
```

## Installation

```bash
git clone https://github.com/matsuokashuhei/dotfiles.git $HOME/.dotfiles
$HOME/.dotfiles/install.sh
```

### Symlinks Created by install.sh

| Source | Target |
|--------|----------|
| `git/config` | `~/.config/git/config` |
| `git/ignore` | `~/.config/git/ignore` |
| `claude/settings.json` | `~/.claude/settings.json` |
| `claude/agents/` | `~/.claude/agents/` |
| `claude/commands/` | `~/.claude/commands/` |
| `claude/rules/` | `~/.claude/rules/` |
| `claude/skills/` | `~/.claude/skills/` |
| `ghostty/config` | `~/.config/ghostty/config` |

Additionally, [usedhonda/statusline](https://github.com/usedhonda/statusline) is cloned to `~/.dotfiles/repos/statusline`, and `statusline.py` is copied to `~/.claude/statusline.py`.

## Updating Statusline

```bash
$HOME/.dotfiles/update.sh
```

Runs `git pull` on `repos/statusline` and overwrites `~/.claude/statusline.py` with the latest `statusline.py`.

## Development Guidelines

### Adding a New Configuration File

1. Create an app-named directory at the repository root (e.g., `zsh/`)
2. Place the configuration file inside (e.g., `zsh/zshrc`)
3. Add symlink creation logic to `install.sh` (follow the existing pattern)

`install.sh` addition pattern:

```bash
# <app-name>
SRC_DIR=$DOTFILES_HOME/<app-name>
DEST_DIR=<target-directory>

mkdir -p $DEST_DIR

for file in <file-name>
do
  if [ -f $DEST_DIR/$file ]; then
    echo "$DEST_DIR/$file already exists, aborting to avoid overwriting."
  else
    echo "installing $file to $DEST_DIR/"
    ln -s $SRC_DIR/$file $DEST_DIR/$file
  fi
done
```

### Adding Claude Code Agents, Skills, Rules, or Commands

Since entire directories are symlinked, simply add new `.md` files to the appropriate directory under `claude/`:

- `claude/agents/` — Agent definitions (e.g., `my-agent.md`)
- `claude/commands/` — Slash command definitions (e.g., `my-command.md`)
- `claude/rules/` — Coding rules & guidelines (e.g., `my-rule.md`)
- `claude/skills/` — Skills (either `my-skill.md` or `my-skill/SKILL.md` for complex skills)

No changes to `install.sh` are needed — new files are automatically available via the directory symlink.

### Git Branch Strategy

- Main branch: `master`
- feature branch → Pull Request → merge into master

## Notes

- `install.sh` does not overwrite existing files (includes existence checks)
- `bash/bash_profile` is not included in `install.sh` (legacy)
- Assumes a macOS-specific environment (Homebrew, `afplay`, etc.)
- Claude Code settings have `defaultMode: "plan"` and `language: "English and Japanese are displayed side by side"` enabled
