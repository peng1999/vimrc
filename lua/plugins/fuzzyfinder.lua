return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "neovim/nvim-lspconfig",
  },
  cmd = 'Telescope',
  keys = function()
    local builtin = require('telescope.builtin')
    return {
      { '<Leader>ff', builtin.find_files },
      { '<Leader>fg', builtin.live_grep },
      { '<Leader>fb', builtin.buffers },
      { '<Leader>R',  builtin.resume },
      { 'gr',         builtin.lsp_references, desc = 'Find references' },
    }
  end,
  opts = function()
    return {
      defaults = {
        mappings = {
          i = {
            ['<Esc>'] = require('telescope.actions').close,
            ['<C-c>'] = false,
            ['<M-p>'] = require('telescope.actions.layout').toggle_preview,
          },
        },
        layout_strategy = 'vertical',
        layout_config = {
          preview_cutoff = 10,
          height = { padding = 0 },
        },
      },
      pickers = {
        find_files = {
          follow = true,
          previewer = false,
        },
        buffers = {
          sort_mru = true,
        },
      },
    }
  end,
}
