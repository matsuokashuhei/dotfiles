#!/bin/bash
INPUT=$(cat)
PLAN=$(printf '%s' "$INPUT" | jq -r '.tool_input.plan // empty' 2>/dev/null)
if [[ -n "$PLAN" ]]; then
  TMPFILE=$(mktemp -t claude-plan.XXXXXX).md
  printf '%s\n' "$PLAN" > "$TMPFILE"
  ( mo --open "$TMPFILE" >/dev/null 2>&1 & )
fi
exit 0
