return {
  'tpope/vim-sensible',

  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    opts = {},
  },

  {
    "windwp/nvim-autopairs",
    event = 'VeryLazy',
    opts = {
      map_cr = true,
    },
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {},
  },

  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = true,
  },

  'vim-utils/vim-husk',
  'machakann/vim-highlightedyank',

  -- {
  --   'github/copilot.vim',
  -- },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
          accept_word = "<M-f>",
        },
      },
    },
  },

  {
    'alohaia/fcitx.nvim',
    enabled = vim.fn.executable('fcitx5-remote'),
    config = function ()
      require 'fcitx' {}
    end,
    cond = vim.env.DISPLAY ~= nil,
  },

  -- filetypes
  'rust-lang/rust.vim',
}
