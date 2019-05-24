call plug#begin('~/.vim/bundle')

"--------------
" Generic edit
"--------------
Plug 'godlygeek/tabular'
Plug 'raimondi/delimitmate'
let delimitMate_expand_cr = 1
Plug 'tomtom/tcomment_vim'

Plug 'Chiel92/vim-autoformat'

Plug 'machakann/vim-highlightedyank'

Plug 'vim-airline/vim-airline'
" call airline#parts#define_minwidth('mode', 6)
let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 79,
    \ 'x': 60,
    \ 'y': 88,
    \ 'warning': 80,
    \ 'error': 80,
    \ }

Plug 'joshdick/onedark.vim'
if has('termguicolors')
    set termguicolors
end
let g:onedark_terminal_italics = 1
let g:airline_theme = 'onedark'


let g:use_coc_nvim = 1
let g:use_languageclient = !g:use_coc_nvim


if g:use_languageclient
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
end

Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

map gz :Denite file_rec<CR>
map gZ :Denite buffer<CR>
map gs :Denite documentSymbol<CR>
map gS :Denite workspaceSymbol<CR>
map ga :Denite codeAction<CR>

" Plug 'zchee/deoplete-go'

"----------------
" External tools
"----------------
Plug 'tpope/vim-fugitive'

Plug 'w0rp/ale'

if has('unix')
    Plug 'lilydjwg/fcitx.vim'
    if !has('gui')
        set ttimeoutlen=100
    end
end

if g:use_coc_nvim
    set hidden

    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
    autocmd FileType json syntax match Comment +\/\/.\+$+

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <Leader>rn <Plug>(coc-rename)

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <Leader>a  <Plug>(coc-codeaction-selected)
    nmap <Leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <Leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <Leader>qf  <Plug>(coc-fix-current)

    let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
    let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
end

if g:use_languageclient
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
    let g:LanguageClient_useFloatingHover = 1

    nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    " nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> <F6> :call LanguageClient_textDocument_rename()<CR>
end

"------------------
" Language support
"------------------

Plug 'sheerun/vim-polyglot' " for multi-language highlight
Plug 'justinmk/vim-syntax-extra' " for Flex and Bison highlight
Plug 'plasticboy/vim-markdown'
autocmd FileType markdown set nofoldenable
Plug 'rust-lang/rust.vim'
Plug 'timonv/vim-cargo'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'JuliaEditorSupport/julia-vim'
let g:default_julia_version = '1.1'
Plug 'Shougo/vinarise.vim'
Plug 'ziglang/zig.vim'

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
