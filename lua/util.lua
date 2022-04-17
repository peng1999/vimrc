local M = {}

-- test if feature is supported
---@param feature string
function M.has(feature)
  return vim.fn.has(feature) == 1
end

-- test if path is an executable
---@param path string
function M.executable(path)
  return vim.fn.executable(path) == 1
end

-- create autocmd that print message when enter buffer that matches pattern
---@param pattern string
---@param msg string
---@param group string|integer
function M.buf_msg_ft(pattern, msg, group)
  local cur_group
  if type(group) == "number" then
    cur_group = group
  else
    -- if group is a string, create a new group under that name
    cur_group = vim.api.nvim_create_augroup(group, {})
  end
  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = pattern,
    callback = function()
      print(msg)
      return true
    end,
    group = cur_group,
  })
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
