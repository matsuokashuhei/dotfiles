#!/bin/bash -eu

DOTFILES_HOME=.dotfiles

print_header() {
  printf "\e[34m"
  echo '------------------------------------------------------------------'
  echo '                      __      __  _____ __                        '
  echo '                 ____/ /___  / /_/ __(_) /__  _____               '
  echo '                / __  / __ \/ __/ /_/ / / _ \/ ___/               '
  echo '               / /_/ / /_/ / /_/ __/ / /  __(__  )                '
  echo '               \__,_/\____/\__/_/ /_/_/\___/____/                 '
  echo '                                                                  '
  echo '                Harder, Better, Faster, Stronger                  '
  echo '                                                                  '
  echo '                  github.com/matsuokashuhei/dotfiles              '
  echo '                                                                  '
  echo '------------------------------------------------------------------'
  printf "\e[0m\n"
}

# bash_profile
DOTFILE=$HOME/.bash_profile
if [ -f $DOTFILE ];
then
  cp $DOTFILE ${DOTFILE}-backup-$(date '+%Y%m%d')
fi
ln -fs $DOTFILES_HOME/bash/bash_profile $DOTFILE

# gitconfig
DOTFILE=$HOME/.gitconfig
if [ -f $DOTFILE ];
then
  cp $DOTFILE ${DOTFILE}-backup-$(date '+%Y%m%d')
fi
ln -fs $DOTFILES_HOME/git/gitconfig $DOTFILE

# gitignore
DOTFILE=$HOME/.gitignore
if [ -f $DOTFILE ];
then
  cp $DOTFILE ${DOTFILE}-backup-$(date '+%Y%m%d')
fi
ln -fs $DOTFILES_HOME/git/gitignore $DOTFILE