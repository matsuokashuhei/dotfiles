#!/usr/bin/env python3
"""UserPromptSubmit hook: detect input language and inject a hint for the
appropriate language-assist subagent.

English heuristic (all must be true):
  - No CJK characters (hiragana, katakana, kanji, fullwidth) in the prompt
  - At least 3 ASCII English words
  - Contains at least one sentence-ending mark (. ? !)

Japanese heuristic (all must be true):
  - Contains at least one hiragana (U+3040–U+309F) or katakana (U+30A0–U+30FF)
  - Total character length >= 8

Output protocol (Claude Code UserPromptSubmit hook):
  - Match: print {"hookSpecificOutput": {"hookEventName": "UserPromptSubmit",
                                          "additionalContext": "<hint>"}}
  - No match or any failure: print {} (pass-through; never block the user)
"""
import json
import re
import sys

CJK_RE = re.compile(r"[぀-ゟ゠-ヿ一-鿿＀-￯]")
HIRAGANA_KATAKANA_RE = re.compile(r"[぀-ゟ゠-ヿ]")
WORD_RE = re.compile(r"\b[A-Za-z][A-Za-z']*\b")
SENTENCE_END_RE = re.compile(r"[.!?]")

ENGLISH_HINT = (
    "[english-detected]\n"
    "The user wrote English. Per global rules (Language Assist), "
    "after replying to the conversation, dispatch the `english-corrector_ja` "
    "subagent via the Agent tool with the user's English text verbatim, and "
    "append the result as a `--- 英文添削 ---` section at the "
    "end of your response."
)

JAPANESE_HINT = (
    "[japanese-detected]\n"
    "ユーザーの入力は日本語のようです。会話への返答とは別に、"
    "`japanese-translator` subagent を Agent ツールで呼び出し、"
    "結果を応答末尾に `--- 英訳 ---` セクションとして追記してください。"
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


def is_japanese(prompt: str) -> bool:
    if not prompt:
        return False
    if not HIRAGANA_KATAKANA_RE.search(prompt):
        return False
    if len(prompt) < 8:
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
        hint = ENGLISH_HINT
    elif is_japanese(prompt):
        hint = JAPANESE_HINT
    else:
        print("{}")
        return

    out = {
        "hookSpecificOutput": {
            "hookEventName": "UserPromptSubmit",
            "additionalContext": hint,
        }
    }
    print(json.dumps(out))


if __name__ == "__main__":
    main()
