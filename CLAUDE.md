# dotfiles

macOS 開発環境の dotfiles リポジトリ。シンボリックリンクで各設定ファイルを管理する。

## リポジトリ構造

```
├── install.sh          # インストールスクリプト（シンボリックリンク作成・statusline セットアップ）
├── update.sh             # statusline 更新スクリプト
├── bash/bash_profile     # Bash シェル設定（レガシー、install.sh 未対応）
├── claude/settings.json  # Claude Code CLI 設定
├── ghostty/config        # Ghostty ターミナル設定
├── git/config            # Git ユーザー設定・エイリアス
└── git/ignore            # グローバル gitignore（macOS 固有ファイル除外）
```

## インストール

```bash
git clone https://github.com/matsuokashuhei/dotfiles.git $HOME/.dotfiles
$HOME/.dotfiles/install.sh
```

### install.sh が作成するシンボリックリンク

| ソース | リンク先 |
|--------|----------|
| `git/config` | `~/.config/git/config` |
| `git/ignore` | `~/.config/git/ignore` |
| `claude/settings.json` | `~/.claude/settings.json` |
| `ghostty/config` | `~/.config/ghostty/config` |

加えて、[usedhonda/statusline](https://github.com/usedhonda/statusline) を `~/.dotfiles/repos/statusline` にクローンし、`statusline.py` を `~/.claude/statusline.py` にコピーする。

## Statusline の更新

```bash
$HOME/.dotfiles/update.sh
```

`repos/statusline` を `git pull` して最新の `statusline.py` を `~/.claude/statusline.py` に上書きコピーする。

## 開発規約

### 新しい設定ファイルの追加手順

1. リポジトリ直下にアプリ名のディレクトリを作成（例: `zsh/`）
2. 設定ファイルを配置（例: `zsh/zshrc`）
3. `install.sh` にシンボリックリンク作成処理を追加（既存パターンに従う）

`install.sh` の追加パターン:

```bash
# <アプリ名>
SRC_DIR=$DOTFILES_HOME/<アプリ名>
DEST_DIR=<リンク先ディレクトリ>

mkdir -p $DEST_DIR

for file in <ファイル名>
do
  if [ -f $DEST_DIR/$file ]; then
    echo "$DEST_DIR/$file already exists, aborting to avoid overwriting."
  else
    echo "installing $file to $DEST_DIR/"
    ln -s $SRC_DIR/$file $DEST_DIR/$file
  fi
done
```

### Git ブランチ戦略

- メインブランチ: `master`
- feature branch → Pull Request → master にマージ

## 注意事項

- `install.sh` は既存ファイルを上書きしない（存在チェックあり）
- `bash/bash_profile` は `install.sh` に含まれていない（レガシー）
- macOS 固有の環境前提（Homebrew、`afplay` など）
- Claude Code の設定で `defaultMode: "plan"`、`language: "japanese"` が有効
