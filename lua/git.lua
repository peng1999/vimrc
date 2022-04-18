return function(packer)
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
