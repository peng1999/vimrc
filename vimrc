set nocompatible              " be IMproved, required

if has('win32') || has ('win64')
    let $VIMHOME = $VIM . "/vimfiles"
else
    let $VIMHOME = $HOME . "/.vim"
endif
if filereadable($VIMHOME . "/plugin.vim")
    source $VIMHOME/plugin.vim
end

if has('unix')
    set shell=/bin/bash
end

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

set shiftwidth=4
set expandtab
set smarttab
set number
set selectmode-=mouse
set autowrite

set mouse=a

" Backup and undofile directory:
" - Make `.` the least choice
" - Make ~/tmp/vimundo and ~/tmp/vimbackup the default on Linux
" - Never use `~` on Linux
set backupdir-=.
set backupdir-=~/
set backupdir+=.
let &undodir=&backupdir
set undodir^=~/tmp/vimundo
set backupdir^=~/tmp/vimbackup

colorscheme torte

augroup cppabbr
    autocmd!
    " Abbrevation for `long *`
    autocmd FileType cpp abbreviate ll long long
    autocmd FileType cpp abbreviate ld long double

    " Typo
    autocmd FileType cpp abbreviate itn int
augroup END

let mapleader="\<Space>"
noremap <Leader><Leader> :noh<CR>
noremap <Leader>b :buf#<CR>

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

if has("nvim")
    tnoremap <ESC> <C-\><C-N>
    augroup terminal
        autocmd!
        autocmd TermOpen * setlocal nonumber
        autocmd TermOpen * noremap <buffer> <Leader>r i<Up><C-\><C-N>
        autocmd TermOpen * noremap <buffer> <Leader><CR> i<CR><C-\><C-N>G
    augroup END
end

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
    set encoding=utf-8
    set fileencodings=utf-8,chinese,latin-1

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

