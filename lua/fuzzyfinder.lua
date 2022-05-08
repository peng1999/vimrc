return function(packer)
  packer {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    cmd = 'Telescope',
    setup = function ()
      vim.keymap.set('n', '<leader>f', '<Cmd>Telescope find_files<CR>')
      vim.keymap.set('n', '<leader>gg', '<Cmd>Telescope live_grep<CR>')
      vim.keymap.set('n', '<leader>gb', '<Cmd>Telescope buffers<CR>')
      vim.keymap.set('n', '<leader>gs', '<Cmd>Telescope lsp_workspace_symbols<CR>')
    end,
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ["<ESC>"] = actions.close,
              ["<C-c>"] = false,
            },
          },
        },
        pickers = {
          find_files = {
            follow = true,
          },
          buffers = {
            sort_mru = true,
          },
        },
      }
    end,
  }
end
