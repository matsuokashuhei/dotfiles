set nocompatible

"================================================
" Vundle Initialization
"================================================
source ~/.vim/vundle.vim

"================================================
" 表示
"================================================
set number
set showcmd
set showmode
set laststatus=2
set cmdheight=2

syntax on

"================================================
" カーソルの移動
"================================================
set backspace=indent,eol,start

"================================================
" ファイルの操作
"================================================
set confirm
set hidden
set autoread

set noswapfile
set nobackup
set nowb

"================================================
" 検索・置換
"================================================
set hlsearch
set incsearch
set ignorecase
set smartcase

"================================================
" タブ・インデント
"================================================
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

"================================================
" ウィンドウ
"================================================
source ~/.vim/tab.vim


"================================================
" その他
"================================================
set history=1000
set visualbell


"source ~/.vim/theme.vim
