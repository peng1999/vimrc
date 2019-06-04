" The theme layer.
if !exists('g:layer_theme_loaded')
    let g:layer_theme_loaded = 1
    Plug 'vim-airline/vim-airline'
    Plug 'joshdick/onedark.vim'
else
" always show current position
let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 79,
    \ 'x': 60,
    \ 'y': 88,
    \ 'warning': 80,
    \ 'error': 80,
    \ }


if has('termguicolors')
    set termguicolors
end
let g:onedark_terminal_italics = 1
let g:airline_theme = 'onedark'

" ignore if onedark theme is not installed
try
    colorscheme onedark
    highlight CocHighlightText guibg=#505050
    highlight clear SpellBad
    highlight SpellBad gui=undercurl
catch
    echomsg 'theme failed to load'
endtry
end
