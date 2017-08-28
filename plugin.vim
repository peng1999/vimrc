call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-fugitive'

Plug 'godlygeek/tabular'
Plug 'raimondi/delimitmate'
autocmd FileType cpp,rust let b:delimitMate_expand_cr = 1


Plug 'Chiel92/vim-autoformat'

Plug 'plasticboy/vim-markdown'
autocmd FileType markdown set nofoldenable
Plug 'rust-lang/rust.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'itchyny/vim-haskell-indent'
Plug 'dag/vim-fish'

Plug 'vim-syntastic/syntastic'
let g:syntastic_rust_checkers = ['cargo']
let g:syntastic_cpp_compiler_options = ' -std=c++1y'
let g:syntastic_haskell_checkers = ['hdevtools', 'hlint']

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

call plug#end()
