---
name: explain-en
description: Use when the user provides English text and wants to understand it in Japanese, including vocabulary and grammar breakdowns.
---

# explain-en

Explain English text in Japanese with vocabulary, grammar, and interpretation support.

## Guidelines

- Input: text provided via `$ARGUMENTS`
- Technical terms: do not translate (e.g., API, async, Docker, Git, CI/CD)
- Formatting: wrap English words in backticks within Japanese text
- Interpretation awareness: when a phrase can be translated in multiple ways, note which interpretation was chosen and list other possible readings

## Instructions

1. Translate `$ARGUMENTS` to Japanese.
2. Output in the following format:

    ```markdown
    ## Translation

    (Japanese translation)

    ## Words and Phrases

    (Key words and phrases with meanings and usage. Be concise.)

    ## Grammar

    (Grammar points found in the text. Be concise.)

    ## Interpretation Notes

    (If any phrase can be translated multiple ways, list interpretations. Omit if only one natural reading.)

    - **[phrase]**
      - ● [interpretation used in translation]
      - ○ [other possible reading(s)]
    ```
