Analyze this conversation and suggest new rules for CLAUDE.md.

## Detection Patterns

Look for these 3 patterns in the conversation:

### 1. Project-specific rules
Phrases like "use X instead of Y", naming rules, or project conventions that apply broadly.

### 2. Repeated corrections
The same type of fix was requested 2 or more times. This shows a pattern that should be a rule.

### 3. Consistency patterns
Phrases like "match this with that", "keep these aligned", or "do it the same way as X".

## Output Format

If you find patterns, output each suggestion like this:

```
### Suggested Rule: [short title]
**Pattern**: [which of the 3 patterns triggered this]
**Reason**: [why this should be a rule]
**Proposed content for CLAUDE.md**:
> [the exact text to add]
```

If no patterns are found, output:
```
No new rules detected in this conversation.
```

## Rules for Proposals

Only suggest rules that meet ALL of these conditions:
- Universal to this project (not a one-time decision)
- Technically correct and easy to understand
- Not already in CLAUDE.md (read it first to check)
- Not a personal preference or temporary workaround
- Useful for future conversations

Read the current CLAUDE.md before making suggestions to avoid duplicates.
