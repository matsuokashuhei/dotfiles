#!/bin/bash
INPUT=$(cat)
PLAN=$(printf '%s' "$INPUT" | jq -r '.tool_input.plan // empty' 2>/dev/null)
if [[ -n "$PLAN" ]]; then
  TMPFILE="${TMPDIR:-/tmp}/claude-plan.$(date +%Y%m%d%H%M%S).md"
  printf '%s\n' "$PLAN" > "$TMPFILE"
  if [[ -n "$CMUX_BUNDLE_ID" ]]; then
    ( mo --no-open "$TMPFILE" >/dev/null 2>&1; sleep 0.3; "${CMUX_CLAUDE_HOOK_CMUX_BIN:-cmux}" browser open http://localhost:6275 >/dev/null 2>&1 ) &
  else
    ( mo --open "$TMPFILE" >/dev/null 2>&1 & )
  fi
fi
exit 0
