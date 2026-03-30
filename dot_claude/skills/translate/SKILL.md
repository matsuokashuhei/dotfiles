---
name: translate
description: Use only when explicitly invoked via /translate.
---

# translate

Auto-detect input language and translate between Japanese and English.

## Guidelines

- Target audience: Japanese users — vocabulary notes and grammar explanations should be in Japanese
- Input: text provided via `$ARGUMENTS`
- Language detection: if input contains hiragana, katakana, or kanji, translate to English; otherwise translate to Japanese
- Technical terms: keep as-is (e.g., API, async, Docker, Git, CI/CD)
- Formatting: wrap English words in backticks within Japanese text; in vocabulary lists, use bold (**word**) instead of backticks
- Vocabulary notes: explain only words that differ from Translation or are notable. Do not repeat explanations already given.

## Instructions

1. Detect the language of `$ARGUMENTS`.
2. Determine if the input is a **word/phrase** or a **sentence**:
   - English: 3 words or fewer → word/phrase mode
   - Japanese: short expression without verb conjugation or particles (e.g. 「先入観」「腹落ちする」) → word/phrase mode
   - Otherwise → sentence mode
3. If Japanese, follow **Japanese to English** below.
4. If English, follow **English to Japanese** below.

### Japanese to English

#### Sentence mode

English style: CEFR B1–B2 — clear, concise, common vocabulary; short sentences.

Globish rules: 1,500-word core vocabulary; max 15 words per sentence; active voice; present and past tense only; no idioms, metaphors, slang, or cultural references; no negative questions.

Output:

    ```markdown
    ## Translation

    (English translation. Preserve original tone.)

    (Vocabulary notes: list English words/phrases and explain each in Japanese.)

    ## Alternatives

    ### Casual

    (Casual rewrite. Be concise.)

    (Vocabulary notes: list English words/phrases and explain each in Japanese.)

    ### Formal

    (Formal rewrite. Be concise.)

    (Vocabulary notes: list English words/phrases and explain each in Japanese.)

    ### Globish

    (Globish rewrite. If Translation already follows Globish, write 「Translation と同じです。」)

    (Vocabulary notes: explain Globish English word choices vs Translation, in Japanese.)
    ```

#### Word/phrase mode

Output:

    ```markdown
    ## English Equivalents

    (Multiple English equivalents with nuance differences for each — in Japanese)

    ## Example Sentences

    (Example sentences for each English equivalent, with Japanese translation. Do not use quotation marks around English sentences or Japanese brackets around translations.)

    ## Synonyms & Antonyms

    (English synonyms and antonyms with nuance differences — in Japanese)

    ## Collocations

    (Common English collocations for each equivalent — in Japanese)
    ```

### English to Japanese

#### Sentence mode

Output:

    ```markdown
    ## Translation

    (Japanese translation)

    ## Words and Phrases

    (Key words and phrases with meanings and usage. Be concise.)

    ## Grammar

    (Grammar points found in the text. Be concise.)

    ```

#### Word/phrase mode

Output:

    ```markdown
    ## Translation

    (Japanese translation)

    ## Meanings & Nuances

    (Multiple meanings, nuance differences, usage context — in Japanese)

    ## Example Sentences

    (2-3 example sentences using the word/phrase, with Japanese translation. Do not use quotation marks around English sentences or Japanese brackets around translations.)

    ## Synonyms & Antonyms

    (Synonyms and antonyms with nuance differences — in Japanese)

    ## Collocations

    (Common collocations/word combinations — in Japanese)
    ```
