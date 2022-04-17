return function(packer)
  local util = require('util')
  if not util.executable('lua-language-server') then
    util.buf_msg_ft('*.lua', 'install lua-language-server to enable LSP', 'lua')
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
