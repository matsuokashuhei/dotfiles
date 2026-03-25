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

## Example

**Input:**
```
The current analysis only covers what happens during the closing process. However, in practice, company name changes are also restricted before and after the closing process.
```

**Output:**

```markdown
## Translation

現在の分析は、締め処理の最中に何が起こるかだけをカバーしています。しかし実際には、会社名の変更は締め処理の前後でも制限されています。

## Words and Phrases

- covers - 「カバーする、対象とする」。分析やドキュメントが「何を扱っているか」を表すときによく使います。
- closing process - 「締め処理」。会計・請求における月次の締め作業。
- in practice - 「実際には、実務では」。理論や分析と現実の違いを示すときに使う表現。
- restricted - 「制限されている」。何かが禁止または制約されている状態。
- before and after - 「前後で」。時間的な範囲を示す。

## Grammar

- only covers what happens - "only" が動詞 "covers" を修飾して「〜だけをカバーする」という限定の意味。"what happens" は関係代名詞 "what"（〜すること）を使った名詞節で、"covers" の目的語になっています。
- However, in practice - "However" は前の文と対比する接続副詞（「しかし」）。"in practice" は副詞句で「実際には」。この2つを文頭に置くことで、「分析ではこうだが、実際には違う」という対比構造を作っています。
- are also restricted - 受動態（be + 過去分詞）。「制限されている」。"also" は「〜もまた」で、締め処理中だけでなく前後でも制限があることを追加しています。
```
