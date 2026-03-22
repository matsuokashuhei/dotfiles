---
name: sync-deployed-to-chezmoi
description: Sync changes from deployed ~/.claude/ files back into the chezmoi source at dot_claude/. Use when the user says deployed files have changes that need to be taken into the chezmoi source.
tools: Read, Edit, Write, Bash, Glob, Grep
---

# sync-deployed-to-chezmoi

Sync changes from deployed `~/.claude/` files back into chezmoi source files under `dot_claude/`.

## File Mapping

| Deployed file | Chezmoi source |
|---|---|
| `~/.claude/settings.json` | `dot_claude/settings.json.tmpl` |
| `~/.claude/hooks/guard_bash.py` | `dot_claude/hooks/executable_guard_bash.py` |
| `~/.claude/CLAUDE.md` | `dot_claude/CLAUDE.md` |
| `~/.claude/statusline.py` | `dot_claude/statusline.py` |

## Instructions

1. Read the deployed file(s) specified in `$ARGUMENTS` (or all mapped files if no argument).
2. Read the corresponding chezmoi source file(s).
3. Identify differences between deployed and source.
4. Apply changes to the chezmoi source file(s).

### Special handling: `settings.json.tmpl`

`dot_claude/settings.json.tmpl` is a Go template, not plain JSON. It contains chezmoi directives:
- `{{- if eq .machineType "personal" }}` / `{{- else }}` / `{{- end }}` blocks
- Personal-only sections: `"model"`, `"enabledPlugins"`, `"extraKnownMarketplaces"`

When syncing from `~/.claude/settings.json`:
- The deployed file is the **rendered** result for the current machine (personal).
- Only add/modify content in the **shared** sections (outside conditionals).
- Do NOT replace template directives with literal values.
- Preserve the template structure exactly.

Shared sections (safe to modify):
- `"env"`, `"includeCoAuthoredBy"`, `"permissions"`, `"hooks"`, `"statusLine"`, `"language"`, `"voiceEnabled"`

Machine-specific sections (do NOT change — managed by template conditionals):
- `"model"` — only present for personal machines
- `"enabledPlugins"` — personal vs work have different values
- `"extraKnownMarketplaces"` — personal only

5. Run `chezmoi diff` and display the output.
6. If diff is clean (no unexpected changes), run `chezmoi apply`.

## Example invocations

- `/sync-deployed-to-chezmoi` — sync all mapped files
- `/sync-deployed-to-chezmoi settings guard_bash` — sync only settings and guard_bash
