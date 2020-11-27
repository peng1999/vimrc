" Plugins that absolutely needed in most circumstance.
Plug 'raimondi/delimitmate'
let delimitMate_expand_cr = 1
au FileType verilog let b:delimitMate_quotes = "\" '"

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'tomtom/tcomment_vim'

Plug 'Chiel92/vim-autoformat'

Plug 'machakann/vim-highlightedyank'

" Command mode
Plug 'vim-utils/vim-husk'

if has('unix')
    Plug 'lilydjwg/fcitx.vim'
    if !has('gui')
        set ttimeoutlen=100
    end
end

Plug 'editorconfig/editorconfig-vim'
