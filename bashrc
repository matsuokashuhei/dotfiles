# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

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
