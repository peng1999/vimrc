return function(add_package)
  add_package {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local typst_path = vim.fn.stdpath('config') .. '/tree-sitter-typst'
      if vim.fn.isdirectory(typst_path) == 1 then
        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        parser_config.typst = {
          install_info = {
            url = typst_path,
            files = { 'src/parser.c', 'src/scanner.cc' },
            branch = 'main',
          },
          filetype = 'typst', -- if filetype does not agrees with parser name
        }

        vim.treesitter.language.register('typst', 'typst')
      end
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
