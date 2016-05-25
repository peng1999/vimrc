set nocompatible

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

set shiftwidth=4
set guifont=Courier_New:h15:cANSI
set expandtab
set number
set selectmode-=mouse

set nobackup

" I don't want these maps in mswin.vim
unmap <C-Y>
iunmap <C-Y>
vunmap <BS>

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

"------------------------------------------------------------------------
" Diff in Windows
"------------------------------------------------------------------------
if has("win32")
    set diffexpr=MyDiff()
endif
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
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

