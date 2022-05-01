return function(packer)
  packer 'tpope/vim-sensible'

  packer 'tpope/vim-surround'
  packer 'tpope/vim-repeat'

  packer {
    'windwp/nvim-autopairs',
    config = function ()
      require('nvim-autopairs').setup{}
    end
  }

  packer {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  packer 'vim-utils/vim-husk'

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

  -- create a directory to hold backup files
  local backup_dir = '/tmp/vimbackup-' .. os.getenv('USER')
  if vim.fn.isdirectory(backup_dir) == 0 then
      print('Creating ' .. backup_dir)
      vim.fn.mkdir(backup_dir, '', tonumber('700', 8))
  end

  vim.opt.undodir:append('.')
  vim.opt.backupdir:prepend(backup_dir)

  -- Color scheme
  vim.cmd 'syntax on'

  -- Filetype
  vim.cmd 'filetype on'
  vim.cmd 'filetype plugin on'
  vim.cmd 'filetype indent on'

  vim.g.mapleader = ' '

  vim.keymap.set('n', '<Leader>n', '<Cmd>noh<CR>')
  vim.keymap.set('n', '<Leader>b', '<Cmd>buf#<CR>')

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
end
