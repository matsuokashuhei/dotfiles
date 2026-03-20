# dotfiles

macOS dotfiles managed by chezmoi.

`machineType`: `"personal"` or `"work"` — controls machine-specific config (Brewfile casks, Claude plugins).

# Development workflow

## Creating or editing files

1. Run `chezmoi diff` — confirm no unexpected changes exist before starting.
2. Make the change (create or edit the source file under `~/.local/share/chezmoi/`).
3. Run `chezmoi diff` again — confirm only your intended changes appear.
4. **Display the `chezmoi diff` output in the chat.**
5. Run `chezmoi apply`.

## Deleting files

Use `chezmoi remove` to delete managed files.

## Before `chezmoi apply`

Always display `chezmoi diff` output in the chat first.
