call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-fugitive'

Plug 'godlygeek/tabular'
Plug 'raimondi/delimitmate'
autocmd FileType cpp,rust let b:delimitMate_expand_cr = 1
Plug 'tomtom/tcomment_vim'

if has('unix')
    Plug 'lilydjwg/fcitx.vim'
    if !has('gui')
        set ttimeoutlen=100
    end
end

Plug 'Chiel92/vim-autoformat'

Plug 'plasticboy/vim-markdown'
autocmd FileType markdown set nofoldenable
Plug 'rust-lang/rust.vim'
Plug 'timonv/vim-cargo'
Plug 'neovimhaskell/haskell-vim'
Plug 'itchyny/vim-haskell-indent'
Plug 'dag/vim-fish'
Plug 'fsharp/vim-fsharp', { 'for': 'fsharp', 'do': 'make fsautocomplete' }

if !has('nvim')
    Plug 'vim-syntastic/syntastic'
    let g:syntastic_rust_checkers = ['cargo']
    let g:syntastic_cpp_compiler_options = ' -std=c++1y'
    let g:syntastic_haskell_checkers = ['hdevtools', 'hlint']

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    " Respect gitignore
    " use ag
    "let $FZF_DEFAULT_COMMAND = 'ag -g ""'
    " use rg
    let $FZF_DEFAULT_COMMAND = 'rg --files'
    map gz :FZF<CR>
end


if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh'
                \ }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

    map gz :Denite file_rec<CR>
    map gZ :Denite buffer<CR>

    set hidden
    let g:LanguageClient_serverCommands = {
                \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
                \ 'python': ['pyls'],
                \ }
                " \ 'cpp': ['cquery', '--log-file=/tmp/cquery.log'],
                " \ 'c': ['cquery', '--log-file=/tmp/cquery.log'],

    " Automatically start language servers.
    let g:LanguageClient_autoStart = 1
    let g:LanguageClient_loadSettings = 1
    let g:deoplete#enable_at_startup = 1

    nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
end

call plug#end()

if has('nvim')
    call denite#custom#var('file_rec', 'command',
                \ ['rg', '--files'])
    call denite#custom#map(
                \ 'insert',
                \ '<C-N>',
                \ '<denite:move_to_next_line>',
                \ 'noremap'
                \)
    call denite#custom#map(
                \ 'insert',
                \ '<C-P>',
                \ '<denite:move_to_previous_line>',
                \ 'noremap'
                \)
end
