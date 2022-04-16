return function(packer)
  packer {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
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
            follow = true
          },
        },
      }

      vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>')
      vim.keymap.set('n', '<leader>gg', ':Telescope live_grep<CR>')
      vim.keymap.set('n', '<leader>gb', ':Telescope buffers<CR>')
      vim.keymap.set('n', '<leader>gs', ':Telescope lsp_workspace_symbols<CR>')
    end,
  }
end
