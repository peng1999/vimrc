return function(add_package)
  add_package {
    'norcalli/nvim-colorizer.lua',
    opts = {'*'},
    main = 'colorizer',
  }

  local function common_config()
    vim.cmd [[
      highlight LspSignatureActiveParameter guifg=NONE ctermfg=NONE guibg=#1d1f21 ctermbg=53 gui=Bold,underline,Italic cterm=Bold,underline,Italic guisp=#fbec9f
    ]]
  end

  add_package {
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
  }

  add_package {
    'chriskempson/vim-tomorrow-theme',
    config = function()
      vim.opt.termguicolors = true
      vim.cmd [[
        colorscheme Tomorrow-Night
        highlight Normal guibg=NONE
        highlight FloatBorder ctermbg=NONE
        highlight NormalFloat guibg=NONE
      ]]
      common_config()
    end,
    priority = 1000,
    cond = function ()
      return require('config').theme == 'tomorrow'
    end
  }

  add_package {
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
  }
end
