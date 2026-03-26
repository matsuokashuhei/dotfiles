---
name: translate
description: Use when the user provides Japanese or English text and wants it translated to the other language, especially when they don't specify a translation direction.
---

# translate

Auto-detect input language and translate between Japanese and English.

## Guidelines

- Input: text provided via `$ARGUMENTS`
- Language detection: if input contains hiragana, katakana, or kanji, translate to English; otherwise translate to Japanese
- Technical terms: keep as-is (e.g., API, async, Docker, Git, CI/CD)
- Formatting: wrap English words in backticks within Japanese text
- Vocabulary notes: explain only words that differ from Translation or are notable. Do not repeat explanations already given.

## Instructions

1. Detect the language of `$ARGUMENTS`.
2. If Japanese, follow **Japanese to English** below.
3. If English, follow **English to Japanese** below.

### Japanese to English

English style: CEFR B2 — clear, well-structured, natural vocabulary.

Output:

    ```markdown
    ## Translation

    (English translation. Preserve original tone.)

    (Vocabulary notes for words differing from Translation.)

    ## Alternatives

    ### Casual

    (Casual rewrite. Be concise.)

    (Vocabulary notes for words differing from Translation.)

    ### Formal

    (Formal rewrite. Be concise.)

    (Vocabulary notes for words differing from Translation.)

    ### Globish

    (Globish rewrite. If Translation already follows Globish, write 「Translation と同じです。」)

    (Vocabulary notes: explain Globish word choices vs Translation.)
    ```

### English to Japanese

Output:

    ```markdown
    ## Translation

    (Japanese translation)

    ## Words and Phrases

    (Key words and phrases with meanings and usage. Be concise.)

    ## Grammar

    (Grammar points found in the text. Be concise.)
    ```
