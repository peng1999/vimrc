# vimrc
My vimrc

## New lua-based config file (Neovim only)
Just symbol link `init.lua` and `lua/` to `~/.config/nvim/` directory. Run `:PackerSync` in the first run to get plugins right.

## Old vimlang-based config file

### Installation
[peng1999/config][config] is recommended to install this vimrc.

### Note
1. This vimrc reads whatever in `layers/` directory in the user config directory, so you can manage your plugins in a separate file.
2. Create directory `~/tmp/vimundo` (for vim) or `~/.config/nvim/undo` (for nvim) and vim will put undofiles there. `./setup` script in [peng1999/config][config] will do that for you.

[config]: https://github.com/peng1999/config
