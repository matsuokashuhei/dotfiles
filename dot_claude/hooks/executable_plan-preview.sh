#!/bin/bash
INPUT=$(cat)
PLAN=$(printf '%s' "$INPUT" | jq -r '.tool_input.plan // empty' 2>/dev/null)
if [[ -n "$PLAN" ]]; then
  TMPFILE="${TMPDIR:-/tmp}/claude-plan.$(date +%Y%m%d%H%M%S).md"
  printf '%s\n' "$PLAN" > "$TMPFILE"
  if [[ -n "$CMUX_BUNDLE_ID" ]]; then
    MO_OPT="--no-open"
  else
    MO_OPT="--open"
  fi
  ( mo "$MO_OPT" "$TMPFILE" >/dev/null 2>&1 & )
fi
exit 0
