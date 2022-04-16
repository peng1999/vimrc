local M = {}

function M.has(feature)
    return vim.fn.has(feature) == 1
end

local function vim_kv_args(args)
  local arg_strs = {}
  for key, arg in pairs(args) do
    table.insert(arg_strs, string.format('%s=%s', key, arg))
  end
  return table.concat(arg_strs, " ")
end

function M.set_highlight(group, args)
  local arg = vim_kv_args(args)
  vim.cmd(string.format('hi %s %s', group, arg))
end

function M.sign_define(name, args)
  local arg = vim_kv_args(args)
  vim.cmd(string.format('sign define %s %s', name, arg))
end

return M
