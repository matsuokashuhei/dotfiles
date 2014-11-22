let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_focus_on_files=1
let g:nerdtree_tabs_autofind=1

" <C-e>でNERDTreeをON/OFFにする。
nmap <silent> <C-e>       :NERDTreeTabsToggle<CR>
vmap <silent> <C-e> <Esc> :NERDTreeTabsToggle<CR>
map  <silent> <C-e>       :NERDTreeTabsToggle<CR>
imap <silent> <C-e> <Esc> :NERDTreeTabsToggle<CR>
cmap <silent> <C-e> <C-u> :NERDTreeTabsToggle<CR>

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
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

