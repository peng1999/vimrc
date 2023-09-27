local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local prefix = vim.fn.stdpath('config')..'/lua/'
if vim.fn.filereadable(prefix..'config.lua') == 0 then
  print('config.lua not found, copying from config.lua.example...')
  vim.fn.system({'cp', prefix..'config.lua.example', prefix..'config.lua'})
end

local plugins = {}
local add_package = function(spec)
  table.insert(plugins, spec)
end

local modules = {
  require("editor"),
  require("git"),
  require("treesitter"),
  require("theme"),
  require("coc"),
}
for _, module in ipairs(modules) do
  module(add_package)
end

require("lazy").setup(plugins)
