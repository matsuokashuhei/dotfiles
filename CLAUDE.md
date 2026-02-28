# dotfiles

Dotfiles repository for macOS development environment. Configuration files are managed via symlinks.

## Repository Structure

```
├── install.sh            # Install script (creates symlinks & sets up plugins)
├── update.sh             # Update script (statusline, ECC, CPO, superpowers)
├── Brewfile              # Homebrew bundle (formulae, casks, fonts)
├── bash/bash_profile     # Bash shell config (legacy, not handled by install.sh)
├── claude/
│   ├── CLAUDE.md         # User-level Claude Code instructions
│   ├── settings.json     # Claude Code CLI settings
│   ├── agents/           # Custom + copied agent definitions ({plugin}--{agent}.md)
│   ├── commands/         # Custom + copied slash commands
│   ├── hooks/            # Hook scripts (security reminder, session-start)
│   ├── rules/            # Coding rules & guidelines (copied from ECC, gitignored)
│   └── skills/           # Custom + copied skill definitions
├── ghostty/config        # Ghostty terminal config
├── git/config            # Git user settings & aliases
├── git/ignore            # Global gitignore (excludes macOS-specific files)
├── lazygit/config.yml    # Lazygit TUI config
├── nvim/                 # Neovim (LazyVim) config
│   ├── init.lua
│   ├── lazy-lock.json
│   ├── lazyvim.json
│   ├── .neoconf.json
│   ├── stylua.toml
│   └── lua/
│       ├── config/       # LazyVim core config (lazy, options, keymaps, autocmds)
│       └── plugins/      # Plugin specs
└── starship/starship.toml # Starship prompt config
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
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `claude/settings.json` | `~/.claude/settings.json` |
| `claude/agents/` | `~/.claude/agents/` |
| `claude/commands/` | `~/.claude/commands/` |
| `claude/rules/` | `~/.claude/rules/` |
| `claude/skills/` | `~/.claude/skills/` |
| `ghostty/config` | `~/.config/ghostty/config` |
| `lazygit/config.yml` | `~/.config/lazygit/config.yml` |
| `nvim/` | `~/.config/nvim` |
| `starship/starship.toml` | `~/.config/starship.toml` |

Additionally, the following repositories are cloned to `~/.dotfiles/repos/` and their assets copied:

| Repository | Clone Path | What's Copied |
|------------|-----------|--------------|
| [usedhonda/statusline](https://github.com/usedhonda/statusline) | `repos/statusline` | `statusline.py` → `~/.claude/statusline.py` |
| [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) | `repos/everything-claude-code` | `rules/common/*.md` → `claude/rules/`. Plugin (agents, skills, commands) still loaded via `settings.json` |
| [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) | `repos/claude-plugins-official` | Agents, commands, skills, hooks → `claude/` (see below) |
| [obra/superpowers](https://github.com/obra/superpowers) | `repos/superpowers` | Agents, commands, skills → `claude/` (see below) |

**Agent naming convention:** Copied agent files use `{plugin}--{agent}.md` prefix to avoid name collisions (e.g., `pr-review-toolkit--code-reviewer.md`, `feature-dev--code-reviewer.md`). Commands and skills have no conflicts and use original names.

**Hooks directory:** `claude/hooks/` contains hook scripts referenced directly from `settings.json` (not symlinked, not a plugin). Includes `security_reminder_hook.py` (from CPO security-guidance) and `superpowers-session-start` (adapted from obra/superpowers).

If `brew` is available, `install.sh` also runs `brew bundle install --file=Brewfile` to install all Homebrew packages.

## Updating

```bash
$HOME/.dotfiles/update.sh
```

Runs `git pull` on all four repos (`repos/statusline`, `repos/everything-claude-code`, `repos/claude-plugins-official`, `repos/superpowers`), then overwrites all copied files (statusline, rules, agents, commands, skills, hooks) with the latest versions.

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

- Main branch: `main`
- feature branch → Pull Request → merge into main

## Notes

- `install.sh` does not overwrite existing files (includes existence checks)
- `bash/bash_profile` is not included in `install.sh` (legacy)
- Assumes a macOS-specific environment (Homebrew, `afplay`, etc.)
- Claude Code settings have `defaultMode: "plan"` and `language: "English and Japanese are displayed side by side"` enabled
- **NEVER use `git -C`** — Always run git commands from the working directory directly. Do not use `git -C <path>` to specify a different directory. This flag bypasses hook-based permission controls.
  - OK: `git show 7e2fd89:install.sh`
  - NG: `git -C /Users/matsuokashuhei/.dotfiles show 7e2fd89:install.sh`

### Hooks

Configured in `claude/settings.json`:

| Hook | Trigger | Action |
|------|---------|--------|
| PreToolUse | Edit/Write | Blocks edits to symlink targets (`~/.config/git/`, `~/.config/ghostty/`, `~/.config/lazygit/`, `~/.config/nvim/`, `~/.config/starship.toml`, `~/.claude/settings.json`, `~/.claude/CLAUDE.md`) |
| PreToolUse | Edit/Write | Security reminder hook (`claude/hooks/security_reminder_hook.py`) — warns about XSS, injection, unsafe patterns |
| PostToolUse | Edit/Write | Runs `bash -n` syntax check on `.sh` files |
| SessionStart | startup/resume/clear/compact | Injects superpowers using-superpowers skill as context (`claude/hooks/superpowers-session-start`) |
| Stop | Session end | Plays notification sound (`Blow.aiff`) |

### Gitignored Paths

| Pattern | Reason |
|---------|--------|
| `repos/` | External cloned repositories |
| `claude/rules/*.md` | Copied from everything-claude-code (not authored here) |
| `claude/agents/*--*.md` | Copied from CPO/superpowers (prefixed agents) |
| `claude/commands/{name}.md` | Copied from CPO/superpowers (10 command files) |
| `claude/skills/{name}/` | Copied from CPO/superpowers (16 skill directories) |
| `claude/hooks/security_reminder_hook.py` | Copied from CPO security-guidance |
| `.claude/settings.local.json` | Machine-specific local settings |
