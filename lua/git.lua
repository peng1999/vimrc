return function(packer)
  -- packer 'tpope/vim-fugitive' -- git
  packer {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function ()
      require('neogit').setup {
        signs = {
          section = { "▶", "▼" },
          item = { "▶", "▼" },
          hunk = { "", "" },
        }
      }
    end
  }
end
