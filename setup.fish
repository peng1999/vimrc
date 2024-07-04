#!/usr/bin/env fish

function check
    echo $argv
    eval $argv
    set s $status
    if not test $s = 0
        echo (set_color red)command not return 0, exit...(set_color normal)
        exit $s
    end
end

function test_not_exist -a dir
    if test ! -e $dir
        return 0
    else
        echo -n (set_color -o)"warning: "(set_color normal)
        echo `$dir` exists, I will not touch it, and the script may not execute currectly.
        return 1
    end
end

function ensure_dir -a dir
    test_not_exist $dir
    and check mkdir -p $dir
end

function try_link -a src dist
    test_not_exist $dist; or return

    ensure_dir (dirname $dist)
    check ln -s $src $dist
end

ensure_dir $HOME/.config/nvim
try_link $PWD/init.lua $HOME/.config/nvim/init.lua
try_link $PWD/lua $HOME/.config/nvim/lua
