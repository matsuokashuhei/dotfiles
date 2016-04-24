" https://blog.hello-world.jp.net/ruby/2764/
NeoBundle 'scrooloose/syntastic'
" syntasticの設定
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
