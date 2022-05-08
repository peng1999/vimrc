return function()
  local group = vim.api.nvim_create_augroup('golang', {})
  vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.go',
    command = 'setlocal noexpandtab shiftwidth=8',
    group = group,
  })

  local util = require('util')
  local candidates = { 'gopls', (vim.env.GOPATH or '') .. '/bin/gopls' }
  local path = ''

  for _, p in ipairs(candidates) do
    if util.executable(p) then
      path = p
      break
    end
  end

  if path == '' then
    util.buf_msg_ft('*.go', 'install gopls to enable LSP', group)
    return
  end

  local nvim_lsp = require 'lspconfig'

  local cfg = {
    on_attach = require('lsp').on_attach,
    cmd = { path },
    settings = {
    },
  }
  nvim_lsp.gopls.setup(cfg)
end
