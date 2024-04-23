local function config_lspconfig()
  -- vim.lsp.set_log_level("debug")

  local lspconfig = require('lspconfig')
  local cmp_nvim_lsp = require('cmp_nvim_lsp')

  ---@param server_opts { is_utf8?: boolean, config?: table }
  ---@return table
  local function get_server_opts(server_opts)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())

    if server_opts.is_utf8 then
      capabilities.offsetEncoding = "utf-8"
    end

    local opts = vim.tbl_deep_extend(
      "force",
      { capabilities = capabilities },
      server_opts.config or {}
    )

    return opts
  end

  ---@type { [string]: { is_utf8?: boolean, config?: table } }
  local servers = {
    bashls = {},
    clangd = { is_utf8 = true },
    cmake = {},
    jsonls = {},
    lua_ls = {},
    nil_ls = {},
    pyright = { is_utf8 = true },
    rust_analyzer = {},
    tinymist = {
      config = {
        root_dir = function(dir)
          return lspconfig.util.find_git_ancestor(dir) or vim.fn.getcwd()
        end
      }
    },
    tsserver = {},
  }

  for server, config in pairs(servers) do
    lspconfig[server].setup(get_server_opts(config))
  end

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
      -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ac', vim.lsp.buf.code_action, opts)
      -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

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
      border = 'rounded',
    },
  })

  -- Signcolumn diagnostic signs
  local signs = { Error = "✘", Warn = "", Hint = "", Info = "" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Hover UI
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    priority = 100,
    dependencies = {
      { "folke/neoconf.nvim" },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = config_lspconfig,
  },
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    opts = {},
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
