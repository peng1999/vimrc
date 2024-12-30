#!/bin/sh

FILE_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p ~/.config/nvim
test -f ~/.config/nvim/init.lua && (echo "init.lua already exists" && exit 1)
ln -s "$FILE_DIR"/init.lua ~/.config/nvim/init.lua
ln -s "$FILE_DIR"/lua ~/.config/nvim/lua

