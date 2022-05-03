return function(packer)
  local function jumpable(n)
    return vim.fn['vsnip#jumpable'](n) == 1
  end
  local function tab_fun()
    return jumpable(1) and '<Plug>(vsnip-jump-next)' or '<Tab>'
  end
  local function stab_fun()
    return jumpable(-1) and '<Plug>(vsnip-jump-prev)' or '<S-Tab>'
  end
  vim.keymap.set({'i', 's'}, '<Tab>', tab_fun, { expr = true, remap = true })
  vim.keymap.set({'i', 's'}, '<S-Tab>', stab_fun, { expr = true, remap = true })

  packer {
    'hrsh7th/nvim-cmp',
    requires = {
      {'hrsh7th/cmp-vsnip', after = 'nvim-cmp'},
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',

      'hrsh7th/cmp-nvim-lsp',
      {'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
      {'hrsh7th/cmp-path', after = 'nvim-cmp'},
      {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'},
    },
    event = {'InsertEnter *', 'CmdlineEnter *'},
    config = function()

      -- Setup nvim-cmp.
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
          -- Specify `cmp.config.disable` if you want to remove the default mapping.
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline {},
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  }
end
