" Config for autozimu/LanguageClient-neovim

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

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
