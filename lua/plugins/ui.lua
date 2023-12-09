return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree reveal<CR>" },
    },
    opts = {
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end
        },
      },
      window = {
        mappings = {
          ['e'] = function() vim.cmd('Neotree focus filesystem left') end,
          ['b'] = function() vim.cmd('Neotree focus buffers left') end,
          ['g'] = function() vim.cmd('Neotree focus git_status left') end,
        },
      },
    },
  },

  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
  },

  -- {
  --   'vim-airline/vim-airline',
  --   dependencies = {
  --     'vim-airline/vim-airline-themes',
  --     'tpope/vim-fugitive', -- for airline-branch to work
  --   },
  --   config = function()
  --     local airline_theme = {
  --       onedark = 'onedark',
  --       tomorrow = 'lucius',
  --       tokyonight = 'lucius',
  --     }
  --     vim.g.airline_theme = airline_theme[require('config').theme]
  --     vim.g['airline#extensions#csv#enabled'] = 1
  --   end,
  -- }

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {
      extensions = { 'lazy', 'neo-tree' },
      options = {
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_c = { 'filename', '%{coc#status()}' },
      },
    }
  },
}
