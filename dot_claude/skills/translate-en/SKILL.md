---
name: translate-en
description: Use when the user provides Japanese text and wants it translated to English, even if they don't explicitly say "translate".
---

# translate-en

Translate Japanese to English optimized for non-native communication.

## Guidelines

- Input: text provided via `$ARGUMENTS`
- Technical terms: keep as-is (e.g., API, async, Docker, Git, CI/CD)
- English style: CEFR B1–B2 — clear, concise, common vocabulary; short sentences
- Formatting: wrap English words in backticks within Japanese text
- Vocabulary notes: explain only words that differ from Translation or are notable. Do not repeat explanations already given.

## Instructions

1. Translate `$ARGUMENTS` to English.
2. Output in the following format:

    ```markdown
    ## Translation

    (English translation. Preserve original tone.)

    (Vocabulary notes for key words. Be concise.)

    ## Alternatives

    ### Casual

    (Casual rewrite. Be concise.)

    (Vocabulary notes for words differing from Translation.)

    ### Formal

    (Formal rewrite. Be concise.)

    (Vocabulary notes for words differing from Translation.)

    ### Globish

    (Globish rewrite. If Translation already follows Globish, write 「Translation と同じです。」)

    Globish rules: 1,500-word core vocabulary; max 15 words per sentence; active voice; present and past tense only; no idioms, metaphors, slang, or cultural references; no negative questions.

    (Vocabulary notes: explain Globish word choices vs Translation.)
    ```
