---
name: translate-ja
description: Translate Japanese to English with vocabulary, casual and formal alternatives. Use this skill whenever the user provides Japanese text and wants it translated to English, even if they don't explicitly say "translate".
---

# translate-ja

Translate Japanese text to English with learning support.

## Guidelines

- Target audience: Japanese English learners
- Input: text provided via `$ARGUMENTS`
- Technical terms: keep as-is (e.g., API, async, Docker, ActiveRecord, Git, CI/CD)
- English level: CEFR B1–B2 — clear, concise, common vocabulary; short sentences; avoid long or difficult expressions
- Formatting: when writing English words within Japanese text, wrap them in backticks (e.g., `concern` は「懸念」)

## Instructions

1. Translate the Japanese text provided in `$ARGUMENTS` to English.
2. Output in the following format:

    ```markdown
    ## Translation

    (English translation here. Preserve the original tone — casual or formal.)

    ## Words and Phrases

    (List key words and phrases with their meanings and usage. Be concise.)

    ## Alternatives

    ### Casual

    (Rewrite the translation in a more casual, conversational tone. Be concise.)

    ### Formal

    (Rewrite the translation in a more formal, professional tone. Be concise.)
    ```
