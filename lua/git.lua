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
end
