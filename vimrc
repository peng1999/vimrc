set nocompatible              " Required only in Vim, not Neovim

if has('win32') || has ('win64')
    let $VIMHOME = $VIM . "/vimfiles"
else
    let $VIMHOME = $HOME . "/.vim"
endif
if filereadable($VIMHOME . "/plugin.vim")
    source $VIMHOME/plugin.vim
end

if has('unix') && $SHELL =~ "fish"
    set shell=/bin/bash
end

" Neovim has a good default and need not vimrc_example.vim
if !has('nvim')
    source $VIMRUNTIME/vimrc_example.vim
end

behave mswin

set shiftwidth=4
set expandtab
set smarttab
set number
set selectmode-=mouse
set autowrite
set undofile

set mouse=a

colorscheme slate

set undodir+=.
" Neovim has a good default
if !has('nvim')
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
end


augroup golang
    autocmd!
    " GoLang programmer always use tabs
    autocmd FileType go set noexpandtab shiftwidth=8
augroup END

augroup cppabbr
    autocmd!
    " Abbrevation for `long *`
    autocmd FileType cpp abbreviate ll long long
    autocmd FileType cpp abbreviate ld long double

    " Typo
    autocmd FileType cpp abbreviate itn int
augroup END

let mapleader="\<Space>"
" No highlight
noremap <Leader><Leader> :noh<CR>
" Previous buffer
noremap <Leader>b :buf#<CR>
" Terminal buffer
noremap <Leader>t :buf term://<CR>
" Clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p

" If in GUI
if has("gui_running") 
    " && has("clipboard")
    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X> "+x

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C> "+y

    " CTRL-V and SHIFT-Insert are Paste
    map <C-V> "+gP
    cmap <C-V> <C-R>+

    " Use CTRL-Q to do what CTRL-V used to do
    noremap <C-Q> <C-V>
endif

" <C-Y> and <C-E> are also available in insert mode.
inoremap <C-Y> <C-O><C-Y>
inoremap <C-E> <C-O><C-E>

augroup session
    autocmd!
    " Recover cursor location when start
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
augroup END


if has("nvim")
    tnoremap <ESC> <C-\><C-N>
    augroup terminal
        autocmd!
        autocmd TermOpen * setlocal nonumber
        autocmd TermOpen * setlocal norelativenumber
        autocmd TermOpen * noremap <buffer> <C-P> i<C-P><C-\><C-N>
        autocmd TermOpen * noremap <buffer> <C-N> i<C-N><C-\><C-N>
        autocmd TermOpen * noremap <buffer> <CR> i<CR><C-\><C-N>G
    augroup END
end

" Use `rg` as grep program
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Quick Compile
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

