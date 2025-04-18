return {
  'tpope/vim-sensible',

  {
    'nmac427/guess-indent.nvim',
    opts = function ()
      vim.api.nvim_create_autocmd("VimEnter", {
        desc = "Guesss indentation when loading a file",
        callback = function()
          require("guess-indent").set_from_buffer(0, true, true)
        end,
      })
      return {
        auto_cmd = true,
      }
    end,
  },

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
    cond = function()
      return vim.fn.executable('fcitx5-remote') == 1 or vim.fn.executable('fcitx-remote') == 1
    end,
    config = function()
      pcall(require'fcitx', {})
    end,
  },

  -- filetypes
  'rust-lang/rust.vim',
}
