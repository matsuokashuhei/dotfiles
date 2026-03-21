#!/bin/bash
# suggest-claude-md-hook.sh
# Runs at SessionEnd and PreCompact to suggest CLAUDE.md improvements.
# Launches a separate Claude session to avoid polluting the current context.

set -euo pipefail

# Infinite loop prevention
if [ "${SUGGEST_CLAUDE_MD_RUNNING:-}" = "1" ]; then
  exit 0
fi

# Ask user for confirmation via macOS dialog
RESPONSE=$(osascript -e 'display dialog "Run suggest-claude-md to analyze this conversation?" buttons {"No", "Yes"} default button "No" with title "Claude Code Hook"' 2>/dev/null || echo "button returned:No")
if [[ "$RESPONSE" != *"Yes"* ]]; then
  exit 0
fi

mkdir -p "$HOME/.claude/tmp" "$HOME/.claude/logs"

LOG_FILE="$HOME/.claude/logs/suggest-claude-md-$(date +%Y%m%d-%H%M%S).log"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >>"$LOG_FILE"
}

log "Hook started"

# Find the most recent conversation JSONL file
CONVERSATION_DIR="$HOME/.claude/projects"
if [ ! -d "$CONVERSATION_DIR" ]; then
  log "No conversation directory found: $CONVERSATION_DIR"
  exit 0
fi

# Get the most recent JSONL file
LATEST_JSONL=$(find "$CONVERSATION_DIR" -name "*.jsonl" -type f -print0 2>/dev/null |
  xargs -0 ls -t 2>/dev/null |
  head -1)

if [ -z "$LATEST_JSONL" ]; then
  log "No JSONL conversation files found"
  exit 0
fi

log "Using conversation: $LATEST_JSONL"

# Extract human and assistant messages from the JSONL
CONVERSATION_SUMMARY=$(jq -r '
  select(.type == "human" or .type == "assistant")
  | if .type == "human" then
      "User: " + (
        if (.message | type) == "string" then .message
        elif (.message | type) == "array" then
          [.message[] | select(.type == "text") | .text] | join(" ")
        else ""
        end
      )
    elif .type == "assistant" then
      "Assistant: " + (
        if (.message | type) == "string" then .message
        elif (.message.content | type) == "array" then
          [.message.content[] | select(.type == "text") | .text] | join(" ")
        elif (.message.content | type) == "string" then .message.content
        else ""
        end
      )
    else empty
    end
' "$LATEST_JSONL" 2>/dev/null | head -500)

if [ -z "$CONVERSATION_SUMMARY" ]; then
  log "No conversation content extracted"
  exit 0
fi

log "Extracted conversation summary ($(echo "$CONVERSATION_SUMMARY" | wc -l | tr -d ' ') lines)"

# Write conversation summary to a temp file for Claude to read
TEMP_CONTEXT="$HOME/.claude/tmp/suggest-claude-md-context-$$.txt"
echo "$CONVERSATION_SUMMARY" >"$TEMP_CONTEXT"

# Launch Claude in a new Terminal window to analyze
osascript -e "
tell application \"Terminal\"
  do script \"SUGGEST_CLAUDE_MD_RUNNING=1 claude --no-session-persistence -p 'Read the file $TEMP_CONTEXT which contains a conversation summary. Then run /suggest-claude-md to analyze it and suggest CLAUDE.md improvements. After you are done, clean up by deleting $TEMP_CONTEXT.' 2>&1 | tee -a $LOG_FILE; rm -f $TEMP_CONTEXT\"
  activate
end tell
" >>"$LOG_FILE" 2>&1

log "Launched Claude analysis in new Terminal window"
log "Hook completed"
