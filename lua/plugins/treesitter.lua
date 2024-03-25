local function config_typst()
  local typst_path = vim.fn.stdpath('config') .. '/tree-sitter-typst'
  if vim.fn.isdirectory(typst_path) == 1 then
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.typst = {
      install_info = {
        url = typst_path,
        files = { 'src/parser.c', 'src/scanner.c' },
      },
      filetype = 'typst', -- if filetype does not agrees with parser name
    }

    vim.treesitter.language.register('typst', 'typst')
  end
end

local function config_treesitter()
  -- Now its built-in
  -- config_typst()

  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'c', 'cpp', 'cuda', 'fish', 'go', 'lua', 'markdown', 'nix', 'python', 'rust', 'typst'
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
