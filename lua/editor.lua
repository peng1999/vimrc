vim.filetype.add({
  extension = {
    typ = 'typst',
    mpp = 'cpp',
    plt = 'gnuplot',
    gnu = 'gnuplot',
    repos = 'yaml',
  }
})

vim.treesitter.language.register('bash', 'PKGBUILD')

-- Options
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.number = true
vim.opt.autowrite = true
vim.opt.undofile = true
vim.opt.backup = true
vim.opt.formatoptions:append('mB')
vim.opt.selectmode:remove('mouse')
vim.opt.showmode = false
vim.opt.mouse = 'a'
vim.opt.updatetime = 300
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.signcolumn = "yes"

if vim.env.TERM == 'wezterm' then
  local osc52 = require('vim.ui.clipboard.osc52')
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = osc52.copy('+'),
      ['*'] = osc52.copy('*'),
    },
    paste = {
      ['+'] = osc52.paste('+'),
      ['*'] = osc52.paste('*'),
    },
  }
end

-- create a directory to hold backup files
local backup_dir = '/tmp/vimbackup-' .. os.getenv('USER')
if vim.fn.isdirectory(backup_dir) == 0 then
  print('Creating ' .. backup_dir)
  vim.fn.mkdir(backup_dir, '', tonumber('700', 8))
end

local undo_dir = vim.fn.stdpath('state') .. '/undo'
if vim.fn.isdirectory(undo_dir) == 0 then
  print('Creating ' .. undo_dir)
  vim.fn.mkdir(undo_dir)
end

-- Backup and undofile directory:
vim.opt.undodir:append('.')
vim.opt.backupdir:prepend(backup_dir)

-- Color scheme
vim.cmd 'syntax on'

-- Filetype
vim.cmd 'filetype on'
vim.cmd 'filetype plugin on'
vim.cmd 'filetype indent on'

-- Keymaps
vim.g.mapleader = ' '

vim.keymap.set('n', '<Leader>n', '<Cmd>noh<CR>')
vim.keymap.set('n', '<Leader><Leader>', '<Cmd>ccl<CR>')
vim.keymap.set('n', '<Leader>b', '<Cmd>buf#<CR>')
-- clipboard
vim.keymap.set({'n', 'v'}, '<Leader>y', '"+y')
vim.keymap.set({'n', 'v'}, '<Leader>p', '"+p')
vim.keymap.set({'n', 'v'}, '<Leader>P', '"+P')

vim.keymap.set({'n', 'v'}, 'j', 'gj')
vim.keymap.set({'n', 'v'}, 'k', 'gk')

vim.keymap.set('c', '<C-P>', '<Up>')
vim.keymap.set('c', '<C-N>', '<Down>')

-- terminal
vim.keymap.set('t', '<ESC>', '<C-\\><C-N>')
local terminal = vim.api.nvim_create_augroup('terminal', {})
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  group = terminal,
  callback = function ()
    vim.wo.number = false
    vim.keymap.set('n', '<C-P>', 'i<C-P><C-\\><C-N>', { buffer = true })
    vim.keymap.set('n', '<C-N>', 'i<C-N><C-\\><C-N>', { buffer = true })
    vim.keymap.set('n', '<CR>',  'i<CR><C-\\><C-N>G', { buffer = true })
  end
})

-- restore last edit position
local session = vim.api.nvim_create_augroup('session', {})
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function ()
    if vim.fn.line([['"]]) > 1 and vim.fn.line([['"]]) <= vim.fn.line('$') then
      vim.cmd('normal! g`"')
    end
  end,
  group = session,
})

-- My shortcut commands
vim.api.nvim_create_user_command('EditInit', 'edit ' .. vim.fn.stdpath('config') .. '/init.lua', {})
vim.keymap.set('n', '<F10>', '<Cmd>!g++ % -o %<.o<CR>')
