local M = {}
function M.init(packer)
  -- basic rust support
  packer 'rust-lang/rust.vim'

  packer {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    config = function ()
      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      local cfg = {
        tools = { -- rust-tools options
          -- Automatically set inlay hints (type hints)
          autoSetHints = true,

          -- Whether to show hover actions inside the hover window
          -- This overrides the default hover handler
          hover_with_actions = true,

          -- how to execute terminal commands
          -- options right now: termopen / quickfix
          executor = require("rust-tools/executors").termopen,

          runnables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
          },

          debuggables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true

            -- rest of the opts are forwarded to telescope
          },

          -- These apply to the default RustSetInlayHints command
          inlay_hints = {

            -- Only show inlay hints for the current line
            only_current_line = false,

            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",

            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = false,

            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",

            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = ": ",

            -- whether to align to the length of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 1,

            -- The color of the hints
            highlight = "Comment",
          },

          hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = "rounded",

            -- whether the hover action window gets automatically focused
            auto_focus = false
          },
        },

        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
        server = {
          on_attach = require('lsp').on_attach,
          cmd = {'rustup', 'run', 'nightly', 'rust-analyzer'},
          -- rust-analyer options
          ["rust-analyzer"] = {
            assist = {
              importGranularity = "module",
            },
            cargo = {
              loadOutDirsFromCheck = true,
            },
            procMacro = {
              enable = true,
            },
            experimental = {
              procAttrMacros = true,
            },
          }
        },
        capabilities = capabilities,
      }

      require'rust-tools'.setup(cfg)
    end,
  }
end

function M.setup()
  local util = require('util')
  if not util.executable('rustup') then
    util.buf_msg_ft('*.rs', 'rustup not found, rust-tools will not load', 'rust')
    return
  end
end

return M
