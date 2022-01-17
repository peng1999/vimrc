return function(packer)
  if vim.fn.executable('lua-language-server') == 0 then
    return
  end

  local nvim_lsp = require 'lspconfig'

  local cfg = {
    on_attach = require('lsp').on_attach,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          enable = true,
          globals = {'vim'},
        },
        workspace = {
          library = {
            [vim.fn.stdpath('config') .. "/lua"] = true,
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
        },
      },
    },
  }
  nvim_lsp.sumneko_lua.setup(cfg)
end
