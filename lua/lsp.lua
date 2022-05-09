local M = {}

function M.init(packer)
  packer {
    'neovim/nvim-lspconfig',
    config = function()
      local function vim_kv_args(args)
        local arg_strs = {}
        for key, arg in pairs(args) do
          table.insert(arg_strs, string.format('%s=%s', key, arg))
        end
        return table.concat(arg_strs, " ")
      end

      local function sign_define(name, args)
        local arg = vim_kv_args(args)
        vim.cmd(string.format('sign define %s %s', name, arg))
      end

      sign_define('LspDiagnosticsSignError',
        {text='x', texthl='LspDiagnosticsError', linehl='', numhl=''})
      sign_define('LspDiagnosticsSignWarning',
        {text='!', texthl='LspDiagnosticsWarning', linehl='', numhl=''})
      sign_define('LspDiagnosticsSignInformation',
        {text='~', texthl='LspDiagnosticsInformation', linehl='', numhl=''})
      sign_define('LspDiagnosticsSignHint',
        {text='?', texthl='LspDiagnosticsHint', linehl='', numhl=''})

      -- Default to use rounded border
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      require('lang/simple')()
      require('lang/rust').setup()
      require('lang/go')()
    end,
  }
  packer {
    "ray-x/lsp_signature.nvim",
    config = function ()
      require "lsp_signature".setup {
        -- floating_window_above_cur_line = true,
        bind = true,
        handler_opts = {
          border = "rounded",
        },
        max_height = 9,
      }
    end,
  }
end

function M.on_attach(client, bufnr)

  local util = require('util')
  local set_highlight = util.set_highlight
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    set_highlight('LspReferenceRead', {cterm='bold', ctermbg='red', guibg='#505050'})
    set_highlight('LspReferenceText', {cterm='bold', ctermbg='red', guibg='#505050'})
    set_highlight('LspReferenceWrite', {cterm='bold', ctermbg='red', guibg='#505050'})
    local group = vim.api.nvim_create_augroup('lsp_document_highlight', {})
    vim.api.nvim_create_autocmd('CursorHold', {
      pattern = '<buffer>',
      callback = vim.lsp.buf.document_highlight,
      group = group,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      pattern = '<buffer>',
      callback = vim.lsp.buf.clear_references,
      group = group,
    })
    -- autocmd('CursorHold', '<buffer>', 'lua vim.diagnostic.open_float()'),
  end
end

return M
