return function(add_package)
  add_package {
    'TimUntersberger/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = {
        section = { "▶", "▼" },
        item = { "▶", "▼" },
        hunk = { "", "" },
      }
    },
    lazy = true,
    cmd = 'Neogit',
  }

  add_package {
    'APZelos/blamer.nvim',
    cmd = { 'BlamerHide', 'BlamerShow', 'BlamerToggle' },
  }
end
