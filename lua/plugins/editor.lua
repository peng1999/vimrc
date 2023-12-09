vim.filetype.add({
  extension = {
    typ = 'typst',
    mpp = 'cpp',
    plt = 'gnuplot',
    gnu = 'gnuplot',
  }
})

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
      map_cr = false,
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

  'github/copilot.vim',

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
