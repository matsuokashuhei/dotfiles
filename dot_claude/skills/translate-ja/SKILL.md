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

## Example
**Input:**
```
少し心配なことをがあったから一度キャンセルしました。そして再びリリースしました。
```

**Output:**
```markdown
### Translation

I had a small concern, so I cancelled the release once. Then I released it again.

### Words and Phrases

- **concern** - 「心配なこと、懸念」。`worry` よりビジネス寄りの表現。
- **cancelled** - 「キャンセルした」。イギリス英語では `cancelled`、アメリカ英語では `canceled` と綴ります。
- **once** - ここでは「一度」の意味。「以前」の意味でも使えるので文脈に注意。
- **released it again** - 「再びリリースした」。`re-released` とも言えます。

### Alternatives

#### Casual

I had a small concern, so I rolled back the release. Then I re-deployed.

- **rolled back** - 「ロールバックした」。デプロイの取り消しに使う技術的な定番表現。
- **re-deployed** - 「再デプロイした」。リリース文脈ではより自然。

#### Formal

Due to a minor concern, I cancelled the deployment once. After confirming it was safe, I proceeded with the release again.

- **Due to** = 「〜のため」。`because` よりフォーマル。
- **proceeded with** = 「〜を進めた」。ビジネス文書でよく使います。
```
