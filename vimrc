set nocompatible              " Required only in Vim, not Neovim

" mapleader should put before source plugin.vim
let mapleader="\<Space>"

" Find config directory
if has('nvim')
    let $VIMHOME = stdpath('config')
else
    if has('win32') || has ('win64')
        let $VIMHOME = $VIM . "/vimfiles"
    else
        let $VIMHOME = $HOME . "/.vim"
    endif
endif

" The Fish Shell is not compatible with some plugins.
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
set autowrite
set undofile
set backup
set formatoptions+=mB
set selectmode-=mouse
set noshowmode
set mouse=a
set updatetime=300
set ignorecase
set smartcase
set breakindent

set fileencodings=ucs-bom,utf-8,cp936,default,latin1

if has('pythonx')
    set pyxversion=3
end

if has('nvim-0.4')
    set wildoptions=pum
    set inccommand=nosplit
end

" Load plugins (in layer files)
if has('nvim')
    let $PLUGINPATH = stdpath('data') . '/bundle'
else
    let $PLUGINPATH = '~/.vim/bundle'
end
if isdirectory($VIMHOME . '/layers')
    let s:layerfiles = split(glob($VIMHOME . '/layers/*.vim'), '\n')
    let g:rerun_layer = []

    " A first pass to load plugins
    call plug#begin($PLUGINPATH)
    for s:layer in s:layerfiles
        execute 'source' s:layer
    endfor
    call plug#end()

    " Some layer needs a second pass
    for s:layer in g:rerun_layer
        execute 'source' s:layer
    endfor
end

" netrw setting
let g:netrw_winsize = 25

" create a directory to hold backup files
let s:backupdir = "/tmp/vimbackup-" . $USER
if !isdirectory(s:backupdir)
    echomsg "Creating " . s:backupdir
    call mkdir(s:backupdir, "", 0700)
end

set undodir+=.
let &backupdir = s:backupdir . "," . &backupdir
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
end

augroup filetype
    autocmd!
    autocmd BufRead,BufNewFile *.s,*.S call dist#ft#FTasm()
    autocmd BufRead,BufNewFile *.s,*.S execute 'set filetype=' . b:asmsyntax
augroup END

augroup tikz
    autocmd!
    autocmd BufRead,BufNewFile *.tikz set filetype=tex
    autocmd BufRead,BufNewFile *.tikz compiler tex
    autocmd BufRead,BufNewFile *.tikz setlocal makeprg=tikzmk\ %\ -x
    autocmd BufRead,BufNewFile *.tex setlocal makeprg=latexmk
augroup END

augroup text
    autocmd!
    autocmd FileType text setlocal textwidth=80
augroup END

augroup golang
    autocmd!
    " GoLang programmer always use tabs
    autocmd FileType go setlocal noexpandtab shiftwidth=8
augroup END

augroup cppabbr
    autocmd!
    " Abbrevation for `long *`
    autocmd FileType cpp abbreviate ll long long
    autocmd FileType cpp abbreviate ld long double

    " Typo
    autocmd FileType cpp abbreviate itn int
augroup END

" Edit init file
command EditInit :e $VIMHOME/init.vim
command EditLayers :e $VIMHOME/layers

" No highlight
noremap <Leader>n :noh<CR>
" Close quickfix window
noremap <Leader><Leader> :ccl<CR>
" Previous buffer
noremap <Leader>b :buf#<CR>
" Terminal buffer
noremap <Leader>t :buf term://<CR>
" Clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>P "+P
" Display Move
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

cnoremap <C-P> <UP>
cnoremap <C-N> <DOWN>

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
        " <C-P> <C-N> and <C-R> works for normal mode in term
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
    noremap <F10> :!g++ % -g -o %<.o<CR>
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
