return function(packer)
  packer {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      local util = require('util')

      util.noremap('n', '<leader>ff', ':Telescope find_files<CR>')
      util.noremap('n', '<leader>fg', ':Telescope live_grep<CR>')
      util.noremap('n', '<leader>fb', ':Telescope buffers<CR>')
      util.noremap('n', '<leader>fs', ':Telescope lsp_workspace_symbols<CR>')
    end,
  }
end
