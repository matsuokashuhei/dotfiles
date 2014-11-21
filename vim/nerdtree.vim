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

" <C-e>でNERDTreeをON/OFFにする。
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
map <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

" 引数なしでVimを開いたとき、NERDTreeを起動する。
autocmd vimenter * if !argc() | NERDTree | endif

" 他のバッファーを閉じたとき、NERDTreeを開いていたら一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" NERDTreeに表示しないファイル
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']

" その他詳しい説明
" http://blog.livedoor.jp/kumonopanya/archives/51048805.html
