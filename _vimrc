" Vundle setup
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'raimondi/delimitmate'

Plugin 'Chiel92/vim-autoformat'

Plugin 'rust-lang/rust.vim'
Plugin 'vim-syntastic/syntastic'
let g:syntastic_rust_checkers = ['rustc']
let g:syntastic_cpp_compiler_options = ' -std=c++1y'

autocmd FileType cpp let b:delimitMate_expand_cr = 1

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

" -----------------------------------------------------

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

set shiftwidth=4
set expandtab
set smarttab
set number
set selectmode-=mouse
set autowrite

set nobackup

colorscheme torte

" Abbrevation for `long *`
autocmd FileType cpp abbreviate ll long long
autocmd FileType cpp abbreviate ld long double

" Typo
autocmd FileType cpp abbreviate itn int

" I don't want these maps in mswin.vim
unmap <C-Y>
iunmap <C-Y>
vunmap <BS>
" If in TUI
if !has("gui_running")
    unmap <C-C>
    unmap <C-V>
    iunmap <C-V>
    unmap <C-Q>
endif

" <C-Y> and <C-E> are also available in insert mode.
inoremap <C-Y> <C-O><C-Y>
inoremap <C-E> <C-O><C-E>

" CTRL-A is Visual all
noremap <C-A> ggVG
inoremap <C-A> <C-O>gg<C-O>V<C-O>G
cnoremap <C-A> <C-C>ggV<C-O>G
onoremap <C-A> <C-C>ggV<C-O>G
snoremap <C-A> <C-C>ggV<C-O>G
xnoremap <C-A> <C-C>ggVG

" Auto Compile
if has("win32")
    noremap <F5> :!%<<CR>
    noremap <F10> :!g++ % -o %<.exe<CR>
else
    noremap <F5> :!./%<.o<CR>
    noremap <F10> :!g++ % -o %<.o<CR>
endif

" Windows only settings
if has("win32")
    " GUI font
    set guifont=Courier_New:h15:cANSI

    " I use DEV-CPP's mingw32-make
    "set makeprg=mingw32-make

    set diffexpr=MyDiff()
endif

" Diff in Windows
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '"' . $VIMRUNTIME . '\diff"'
      let eq = '""'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

