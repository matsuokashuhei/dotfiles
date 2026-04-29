# Language Assist

ユーザー入力の言語に応じて、会話への返答とは別に補助情報を応答末尾に付加する。

## 英文入力時

`UserPromptSubmit` hook が `[english-detected]` ヒントを注入したとき（または hook が検知しなくても自分で英文と判断したとき）、会話への返答と並行して `english-corrector_ja` subagent を Agent ツールで呼び出し、結果を応答末尾に `--- 英文添削 ---` セクションとして追記する。

## 日本語入力時

`UserPromptSubmit` hook が `[japanese-detected]` ヒントを注入したとき（または hook が検知しなくても自分で日本語と判断したとき）、会話への返答と並行して `japanese-translator` subagent を Agent ツールで呼び出し、結果を応答末尾に `--- 英訳 ---` セクションとして追記する。

## 除外（添削・翻訳しない）

- コードスニペット・コマンド断片・固有名詞列・ファイル名列など「単なる単語の並び」。完全な文（主語＋動詞、または疑問・命令文）であるときのみ対象。
- 「ignore english correction」「skip correction」「ignore translation」「skip translation」のように明示的にオフにする指示があるとき。
- 入力が極端に短い（1〜2 単語）とき。
