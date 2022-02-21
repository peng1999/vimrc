return function(packer)
  if vim.fn.executable('pyright-langserver') == 0 then
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
