return function(packer)
  local util = require('util')
  if not util.executable('pyright-langserver') then
    util.buf_msg_ft('*.py', 'install pyright-langserver to enable LSP', 'py')
    return
  end

  local nvim_lsp = require 'lspconfig'

  local cfg = {
    on_attach = require('lsp').on_attach,
    settings = {
    },
  }
  nvim_lsp.pyright.setup(cfg)
end
