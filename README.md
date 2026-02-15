# dotfiles

Dotfiles repository for macOS development environment. Configuration files are managed via symlinks.

## Repository Structure

```
├── install.sh            # Install script (creates symlinks & sets up plugins)
├── update.sh             # Update script (statusline + everything-claude-code)
├── Brewfile              # Homebrew bundle (formulae, casks, fonts)
├── bash/bash_profile     # Bash shell config (legacy, not handled by install.sh)
├── claude/
│   ├── settings.json     # Claude Code CLI settings
│   ├── agents/           # Custom agent definitions
│   ├── commands/         # Slash command definitions
│   ├── rules/            # Coding rules & guidelines (copied from ECC, gitignored)
│   └── skills/           # Skill definitions (add-config, learned/)
├── ghostty/config        # Ghostty terminal config
├── git/
│   ├── config            # Git user settings & aliases
│   └── ignore            # Global gitignore (excludes macOS-specific files)
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
| `claude/settings.json` | `~/.claude/settings.json` |
| `claude/agents/` | `~/.claude/agents/` |
| `claude/commands/` | `~/.claude/commands/` |
| `claude/rules/` | `~/.claude/rules/` |
| `claude/skills/` | `~/.claude/skills/` |
| `ghostty/config` | `~/.config/ghostty/config` |
| `starship/starship.toml` | `~/.config/starship.toml` |

Additionally, [usedhonda/statusline](https://github.com/usedhonda/statusline) is cloned to `~/.dotfiles/repos/statusline`, and `statusline.py` is copied to `~/.claude/statusline.py`.

[affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) is cloned to `~/.dotfiles/repos/everything-claude-code`, and its common rules are copied to `claude/rules/`. The plugin itself (agents, skills, commands) is enabled via `settings.json`. Copied rule files are gitignored.

If `brew` is available, `install.sh` also runs `brew bundle install --file=Brewfile` to install all Homebrew packages.

## Updating

```bash
$HOME/.dotfiles/update.sh
```

Runs `git pull` on `repos/statusline` and `repos/everything-claude-code`, then overwrites `~/.claude/statusline.py` and `claude/rules/*.md` with the latest versions.

## Notes

- `install.sh` does not overwrite existing files (includes existence checks)
- `bash/bash_profile` is not included in `install.sh` (legacy)
- Assumes a macOS-specific environment (Homebrew, `afplay`, etc.)
- Claude Code settings have `defaultMode: "plan"` and `language: "English and Japanese are displayed side by side"` enabled

## Contributing

See [CLAUDE.md](CLAUDE.md) for development guidelines, hooks, gitignored paths, and other contributor details.
