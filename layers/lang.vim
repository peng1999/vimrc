" Language and git support

Plug 'sheerun/vim-polyglot' " for multi-language highlight
let g:polyglot_disabled = ['sensible', 'v', 'visual-basic', 'lifelines']
Plug 'justinmk/vim-syntax-extra' " for Flex and Bison highlight
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
autocmd FileType markdown set nofoldenable
Plug 'rust-lang/rust.vim'
autocmd FileType rust map <M-S-L> :RustFmt<CR>
Plug 'qnighy/lalrpop.vim'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'JuliaEditorSupport/julia-vim'
Plug 'Shougo/vinarise.vim'
" Plug 'ziglang/zig.vim'
" Plug 'jvoorhis/coq.vim'
Plug 'lervag/vimtex'
autocmd FileType tex map <buffer> <LocalLeader>ll :w<CR>:VimtexCompileSS<CR>
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-xelatex',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
