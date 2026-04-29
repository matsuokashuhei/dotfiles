# English Correction Fork

`UserPromptSubmit` hook が `[english-detected]` ヒントを注入したとき（または hook が検知しなくても自分で英文と判断したとき）、会話への返答と並行して `english-corrector_ja` subagent を Agent ツールで呼び出し、結果を応答末尾に `--- 英文添削 ---` セクションとして追記する。

**除外（添削しない）:**

- コードスニペット・コマンド断片・固有名詞列・ファイル名列など「単なる技術的英単語の並び」。完全な文（主語＋動詞、または疑問・命令文）であるときのみ対象。
- 「ignore english correction」「skip correction」のように明示的に添削をオフにする指示があるとき。
