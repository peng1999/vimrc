local function lua_settings()
  return {
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
  }
end

return function(packer)
  local util = require('util')
  local nvim_lsp = require 'lspconfig'

  local lang_cfg = {
    {
      lsp = 'pyright',
      executable = 'pyright-langserver',
      pattern = '*.py',
      settings = {},
    },
    {
      lsp = 'sumneko_lua',
      executable = 'lua-language-server',
      pattern = '*.lua',
      settings = lua_settings(),
    },
    {
      lsp = 'rnix',
      executable = 'rnix-lsp',
      pattern = '*.nix',
      settings = {},
    }
  }

  for _, cfg in ipairs(lang_cfg) do
    if not util.executable(cfg.executable) then
      util.buf_msg_ft(
        cfg.pattern,
        'install ' .. cfg.executable .. ' to enable LSP',
        cfg.lsp
      )
      goto continue
    end

    nvim_lsp[cfg.lsp].setup({
      on_attach = require('lsp').on_attach,
      settings = cfg.settings,
    })

    ::continue::
  end

end
