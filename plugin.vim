call plug#begin('~/.vim/bundle')

"--------------
" Generic edit
"--------------
Plug 'godlygeek/tabular'
Plug 'raimondi/delimitmate'
let b:delimitMate_expand_cr = 1
Plug 'tomtom/tcomment_vim'

Plug 'Chiel92/vim-autoformat'

Plug 'vim-airline/vim-airline'
" call airline#parts#define_minwidth('mode', 6)
let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 79,
    \ 'x': 60,
    \ 'y': 88,
    \ 'warning': 80,
    \ 'error': 80,
    \ }

if !has('nvim')
    Plug 'vim-syntastic/syntastic'
    let g:syntastic_rust_checkers = ['cargo']
    let g:syntastic_cpp_compiler_options = ' -std=c++1y'
    let g:syntastic_haskell_checkers = ['hdevtools', 'hlint']

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    " Respect gitignore
    " use rg
    let $FZF_DEFAULT_COMMAND = 'rg --files'
    map gz :FZF<CR>
end


if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

    map gz :Denite file_rec<CR>
    map gZ :Denite buffer<CR>

    " Plug 'zchee/deoplete-go'
end

"----------------
" External tools
"----------------
Plug 'tpope/vim-fugitive'

if has('unix')
    Plug 'lilydjwg/fcitx.vim'
    if !has('gui')
        set ttimeoutlen=100
    end
end

if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh'
                \ }

    set hidden
    let g:LanguageClient_serverCommands = {
                \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
                \ 'python': ['pyls'],
                \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
                \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
                \ 'go': [$GOPATH . '/bin/bingo'],
                \ 'julia': ['lsp.jl'],
                \ }

    for [lag, cmd] in items(g:LanguageClient_serverCommands)
        if executable(cmd[0])
            execute 'autocmd FileType ' . lag . ' nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>'
        else
            unlet g:LanguageClient_serverCommands[lag]
        endif
    endfor

    let g:LanguageClient_settingsPath = '/home/$USER/.config/nvim/settings.json'

    " Automatically start language servers.
    let g:LanguageClient_autoStart = 1
    let g:LanguageClient_loadSettings = 1
    let g:deoplete#enable_at_startup = 1

    nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    " nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> <F6> :call LanguageClient_textDocument_rename()<CR>
end

"------------------
" Language support
"------------------

Plug 'plasticboy/vim-markdown'
autocmd FileType markdown set nofoldenable
Plug 'rust-lang/rust.vim'
Plug 'timonv/vim-cargo'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neovimhaskell/haskell-vim'
Plug 'itchyny/vim-haskell-indent'
Plug 'dag/vim-fish'
Plug 'fsharp/vim-fsharp', { 'for': 'fsharp', 'do': 'make fsautocomplete' }
Plug 'jvoorhis/coq.vim'
Plug 'let-def/vimbufsync' " required by coquille
Plug 'the-lambda-church/coquille'
Plug 'justinmk/vim-syntax-extra'
Plug 'JuliaEditorSupport/julia-vim'
let g:default_julia_version = '1.1'
Plug 'Shougo/vinarise.vim'

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
