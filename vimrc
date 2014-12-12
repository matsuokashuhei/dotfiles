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
set ruler

syntax on

"================================================
" カーソルの移動
"================================================
set backspace=indent,eol,start
set nostartofline

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
" 補完
"================================================
set wildmenu

"================================================
" 検索・置換
"================================================
set hlsearch
nnoremap <C-L> :nohl<CR><C-L>
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
"source ~/.vim/tab.vim


"================================================
" 折りたたみ
"================================================
set foldmethod=syntax
set foldlevel=100

"================================================
" その他
"================================================
set history=1000
set visualbell
set t_vb=
set mouse=a

