local function config_treesitter()
      require("nvim-treesitter").setup({})

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(args)
          -- 只处理临时浮窗/临时文档，别影响真正的 markdown 文件
          if vim.bo[args.buf].buftype == "nofile" then
            vim.schedule(function()
              pcall(vim.treesitter.stop, args.buf)
            end)
          end
        end,
      })

      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.o.foldenable = false
end

return {
  {
    "neovim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "neovim-treesitter/treesitter-parser-registry",
    },
    config = config_treesitter,
  },
}
