NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jistr/vim-nerdtree-tabs.git'
" カラーの有無
" 0 : なし
" 1 : あり
let g:NERDChristmasTree=1

" ブックマークやヘルプのショートカットの表示
" 0 : 表示しない。
" 1 : 表示する。
let NERDTreeMinimalUI=1

" ファイルを開いたときの動作
" 0 : NERDTreeを開いたままにする。
" 1 : NERDTreeを閉じる。
let g:NERDTreeQuitOnOpen=0

" ツリーの外観
" 0 : 綺麗に表示する。
" 1 : 普通に表示する。
let NERDTreeDirArrows=1

" NERDTreeの幅
let g:NERDTreeWinSize=30

" 隠しファイルの表示
" 0 : 表示しない。
" 1 : 表示する。
let g:NERDTreeShowHidden=0

" マウスの操作方法
" 1 : ファイル、ディレクトリをダブルクリックで開く。
" 2 : ディレクトリのみシングルクリックで開く。
" 3 : ファイル、ディレクトリともにシングルクリックで開く。
let g:NERDTreeMouseMode=2

" 引数なしでVimを開いたとき、NERDTreeを起動する。
"autocmd vimenter * if !argc() | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" 他のバッファーを閉じたとき、NERDTreeを開いていたら一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTreeに表示しないファイル
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']

map <C-n> :NERDTreeToggle<CR>

" その他詳しい説明
" http://blog.livedoor.jp/kumonopanya/archives/51048805.html

" NERDTree and tabs
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_focus_on_files=1
let g:nerdtree_tabs_autofind=1

" The prefix key.
nnoremap [Tag] <Nop>
nmap t [Tag]
" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>
