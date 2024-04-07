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
    cond = not require('util').config_disabled('copilot'),
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = false, -- This will be handled by the completion plugin
          accept_line = "<C-f>",
          accept_word = "<M-f>",
        },
      },
    },
  },

  {
    'alohaia/fcitx.nvim',
    config = function ()
      require 'fcitx' {}
    end,
  },

  -- filetypes
  'rust-lang/rust.vim',
}
