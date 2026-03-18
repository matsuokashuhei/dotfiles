# Lessons Learned

## 2026-03-18: Plugin cache is remote-sourced

**Problem**: Renaming skills locally (in chezmoi source) did not update the Claude Code plugin cache. Old skill names persisted.

**Root cause**: The plugin cache (`~/.claude/plugins/cache/`) is populated from the GitHub marketplace (remote repo), not from local source files. Local edits have no effect on the cache.

**Workaround**: Manually delete old cache entries and copy new files into the cache directory for local testing.

**Permanent fix**: Push changes to GitHub so the next cache refresh picks them up.

**Prevention**: When renaming or modifying plugin skills, always verify the cache directory reflects your changes. Do not assume local edits propagate automatically.

---

## 2026-03-18: Skill naming for learners

**Problem**: Skill names like `proofread` and `interpret` are too advanced for English learners.

**Solution**: Use simple, common English words that learners already know.

- `proofread` → `correct`
- `interpret` → `explain`

**Prevention**: When naming skills targeted at English learners, prefer everyday vocabulary. Ask: "Would a CEFR A2-B1 learner know this word?"
