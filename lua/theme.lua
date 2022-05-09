return function(packer)
  packer {
    'vim-airline/vim-airline',
    requires = {
      'vim-airline/vim-airline-themes',
      'tpope/vim-fugitive', -- for airline-branch to work
    },
    config = function()
      local airline_theme = {
        onedark = 'onedark',
        tomorrow = 'lucius',
      }
      vim.g.airline_theme = airline_theme[require('config').theme]
      vim.g['airline#extensions#csv#enabled'] = 1
    end,
  }

  function common_config()
    vim.cmd [[
      highlight LspSignatureActiveParameter guifg=NONE ctermfg=NONE guibg=#1d1f21 ctermbg=53 gui=Bold,underline,Italic cterm=Bold,underline,Italic guisp=#fbec9f
    ]]
  end

  packer {
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
    cond = function ()
      return require('config').theme == 'onedark'
    end
  }

  packer {
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
    cond = function ()
      return require('config').theme == 'tomorrow'
    end
  }
end
