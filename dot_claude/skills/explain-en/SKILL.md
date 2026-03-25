---
name: explain-en
description: Translate English to Japanese with grammar and vocabulary explanations. Use this skill whenever the user provides English text and wants to understand it in Japanese, including vocabulary and grammar breakdowns.
---

# explain-en

Translate English text to Japanese with learning support.

## Guidelines

- Target audience: Japanese English learners
- Input: text provided via `$ARGUMENTS`
- Technical terms: do not translate (e.g., API, async, Docker, ActiveRecord, Git, CI/CD)
- English level: CEFR B1–B2 — clear, concise, common vocabulary; short sentences; avoid long or difficult expressions
- Formatting: when writing English words within Japanese text, wrap them in backticks (e.g., `concern` は「懸念」)

## Instructions

1. Translate the English text provided in `$ARGUMENTS` to Japanese.
2. Output in the following format:

    ```markdown
    ## Translation

    (Japanese translation here)

    ## Words and Phrases

    (List key words and phrases with their meanings and usage. Be concise.)

    ## Grammar

    (Explain grammar points found in the text. Be concise.)
    ```
