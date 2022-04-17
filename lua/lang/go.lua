return function(packer)
  local group = vim.api.nvim_create_augroup('golang', {})
  vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.go',
    command = 'setlocal noexpandtab shiftwidth=8',
    group = group,
  })

  local candidates = { 'gopls', vim.env.GOPATH .. '/bin/gopls' }
  local path = ''

  for _, p in ipairs(candidates) do
    if vim.fn.executable(p) == 1 then
      path = p
      break
    end
  end

  if path == '' then
    vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
      pattern = '*.go',
      callback = function() print('install gopls to enable LSP') end,
      group = group,
    })
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
