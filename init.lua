local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local prefix = fn.stdpath('config')..'/lua/'
if fn.filereadable(prefix..'config.lua') == 0 then
  print('config.lua not found, copying from config.lua.example...')
  fn.system({'cp', prefix..'config.lua.example', prefix..'config.lua'})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  local p = use

  require('editor')(p)
  require('theme')(p)
  require('fuzzyfinder')(p)
  require('git')(p)
  require('treesitter')(p)
  require('lsp').init(p)
  require('nvim-cmp')(p)

  require('lang/simple')(p)
  require('lang/rust')(p)
  require('lang/go')(p)

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
