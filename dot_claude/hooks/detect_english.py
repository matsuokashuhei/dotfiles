#!/usr/bin/env python3
"""UserPromptSubmit hook: detect when the user wrote a full English sentence
and inject a hint that tells the main Claude to dispatch the
`english-corrector_ja` subagent for proofreading.

Heuristic (all must be true):
  - No CJK characters (hiragana, katakana, kanji, fullwidth) in the prompt
  - At least 3 ASCII English words
  - Contains at least one sentence-ending mark (. ? !)

Output protocol (Claude Code UserPromptSubmit hook):
  - Match: print {"hookSpecificOutput": {"hookEventName": "UserPromptSubmit",
                                          "additionalContext": "<hint>"}}
  - No match or any failure: print {} (pass-through; never block the user)
"""
import json
import re
import sys

CJK_RE = re.compile(r"[぀-ゟ゠-ヿ一-鿿＀-￯]")
WORD_RE = re.compile(r"\b[A-Za-z][A-Za-z']*\b")
SENTENCE_END_RE = re.compile(r"[.!?]")

HINT = (
    "[english-detected]\n"
    "The user wrote English. Per global CLAUDE.md (English Correction Fork), "
    "after replying to the conversation, dispatch the `english-corrector_ja` "
    "subagent via the Agent tool with the user's English text verbatim, and "
    "append the result as a `--- 英文添削 ---` section at the "
    "end of your response."
)


def is_english_sentence(prompt: str) -> bool:
    if not prompt:
        return False
    if CJK_RE.search(prompt):
        return False
    if len(WORD_RE.findall(prompt)) < 3:
        return False
    if not SENTENCE_END_RE.search(prompt):
        return False
    return True


def main() -> None:
    try:
        data = json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError):
        print("{}")
        return

    prompt = data.get("prompt", "") if isinstance(data, dict) else ""
    if is_english_sentence(prompt):
        out = {
            "hookSpecificOutput": {
                "hookEventName": "UserPromptSubmit",
                "additionalContext": HINT,
            }
        }
        print(json.dumps(out))
    else:
        print("{}")


if __name__ == "__main__":
    main()
