local function common_config()
  vim.cmd [[
  highlight LspSignatureActiveParameter guifg=NONE ctermfg=NONE guibg=#1d1f21 ctermbg=53 gui=Bold,underline,Italic cterm=Bold,underline,Italic guisp=#fbec9f
  ]]
end

return {
  {
    'norcalli/nvim-colorizer.lua',
    opts = {'*'},
    main = 'colorizer',
  },

  {
    'joshdick/onedark.vim',
    config = function ()
      vim.opt.termguicolors = true
      vim.g.onedark_terminal_italics = 1
      vim.cmd [[
      colorscheme onedark
      highlight CocHighlightText guibg=#505050
      highlight clear SpellBad
      highlight SpellBad gui=undercurl
      highlight GitGutter ctermfg=White guifg=#a0a0a0
      ]]
      common_config()
    end,
    priority = 1000,
    cond = function ()
      return require('config').theme == 'onedark'
    end
  },

  {
    "EdenEast/nightfox.nvim",
    config = function()
      require('nightfox').setup{
        options = {
          -- transparent = true,
        },
      }
      vim.cmd [[
        colorscheme nightfox
      ]]
      common_config()
    end,
    priority = 1000,
    cond = function ()
      return require('config').theme == 'nightfox'
    end
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd[[
        colorscheme tokyonight
        highlight CocHighlightText guibg=#353e5f
        highlight link @identifier @variable.builtin
      ]]
    end,
    cond = function ()
      return require('config').theme == 'tokyonight'
    end
  },

  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      vim.cmd[[
        colorscheme kanagawa
      ]]
    end,
    cond = function ()
      return require('config').theme == 'kanagawa'
    end
  }
}
