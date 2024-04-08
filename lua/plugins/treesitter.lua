local function config_treesitter()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'c', 'cpp', 'cuda', 'fish', 'go', 'lua', 'markdown', 'nix', 'python', 'rust',
      'typst', 'vim', 'vimdoc'
    },
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
    },
  }

  vim.wo.foldenable = false
  vim.wo.foldmethod = 'expr'
  vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = config_treesitter,
  },
}
