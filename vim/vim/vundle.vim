" Vundleの設定
" https://github.com/timss/vimconf/blob/master/.vimrc を参考にした。
filetype off

let has_vundle=1
if !filereadable($HOME."/.vim/bundle/Vundle.vim/README.md")
  echo "Installing Vundle..."
  echo ""
  silent !mkdir -p $HOME/.vim/bundle
  silent !git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
  let has_vundle=0
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

source $HOME/.vim/plugin.vim

call vundle#end()

if has_vundle == 0
  :silent! PluginInstall
  :qa
endif

filetype plugin indent on

