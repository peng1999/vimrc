local function config_lspconfig()
  vim.lsp.set_log_level("debug")

  local lspconfig = require('lspconfig')
  local utf8_cap = {
    offsetEncoding = "utf-8",
  }
  local function get_server_opts(add_opts)
    local cap = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require('cmp_nvim_lsp').default_capabilities(),
      add_opts or {}
    )
    return { capabilities = cap }
  end
  lspconfig.bashls.setup(get_server_opts())
  lspconfig.clangd.setup(get_server_opts(utf8_cap))
  lspconfig.cmake.setup(get_server_opts())
  lspconfig.lua_ls.setup(get_server_opts())
  lspconfig.nil_ls.setup(get_server_opts())
  lspconfig.pyright.setup(get_server_opts(utf8_cap))
  lspconfig.rust_analyzer.setup(get_server_opts())

  lspconfig.tinymist.setup(vim.tbl_deep_extend("force", get_server_opts(), {
    root_dir = function(dir)
      return lspconfig.util.find_git_ancestor(dir) or lspconfig.util.path.dirname(dir)
    end
  }))

  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gh', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ac', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

      vim.api.nvim_create_user_command('Format', function()
        vim.lsp.buf.format { async = true }
      end, {})
    end,
  })

  -- Diagnostic configuration
  vim.diagnostic.config({
    severity_sort = true,
    float = {
      scope = 'cursor',
    },
  })

  local signs = { Error = "✘", Warn = "", Hint = "", Info = "" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    priority = 100,
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim",  opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = config_lspconfig,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {},
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      hint_enable = false,
    },
  },

  {
    "mrded/nvim-lsp-notify",
    event = "VeryLazy",
    dependencies = { "rcarriga/nvim-notify" },
    config = function()
      require('lsp-notify').setup {
        notify = require("notify"),
      }
    end,
  }
}
