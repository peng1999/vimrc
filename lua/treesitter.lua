return function(add_package)
  add_package {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'c', 'cpp', 'cuda', 'fish', 'go', 'lua', 'markdown', 'nix', 'python', 'rust'
        },
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
        },
        -- indent = {
        --   enable = true,
        -- },
      }

      vim.wo.foldenable = false
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    end
  }
end
