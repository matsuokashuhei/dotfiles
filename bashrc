# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Git
source .git-completion.bash
source .git-prompt.sh
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
# ターミナルのコマンド受付状態の表示変更
# \u ユーザ名
# \h ホスト名
# \W カレントディレクトリ
# \w カレントディレクトリのパス
# \n 改行
# \d 日付
# \[ 表示させない文字列の開始
# \] 表示させない文字列の終了
# \$ $
#export PS1='\[\033[1;32m\]\u\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '
# プロンプトに各種情報を表示
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1

# User specific aliases and functions
case $OSTYPE in
darwin*)
  alias ls='ls -G'
  alias ll='ls -l'
  alias la='ll -a'
  alias h='history'
  alias c='clear'
  ;;
linux*)
  alias vi='vim'
  alias ll='ls -l'
  alias la='ll -a'
  alias h='history'
  alias c='clear'
  ;;
esac
