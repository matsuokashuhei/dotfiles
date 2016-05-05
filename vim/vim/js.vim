Plugin 'othree/yajs.vim'
Plugin 'othree/es.next.syntax.vim'
Plugin 'mxw/vim-jsx'

let g:jsx_ext_required = 1
let g:jsx_pragma_required = 0

augroup Vimrc
  autocmd!
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END


let g:ycm_collect_identifiers_from_tags_files = 1
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:EclimCompletionMethod = 'omnifunc'
autocmd Vimrc FileType javascript nnoremap ,gd :<C-u>YcmCompleter GetDoc<CR>
autocmd Vimrc Filetype javascript nnoremap ,gt :<C-u>YcmCompleter GoTo<CR>
autocmd Vimrc FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

