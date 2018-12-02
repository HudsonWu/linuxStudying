#!/bin/bash
# Epoch 新纪元

if [ ! -f ~/.vimrc ]; then
    echo "Please make sure you have installed vim"
    exit 1
elif [ ! -f ./vimrc.bak -o ! -f ./mtime ]; then
    echo "Please make sure vimrc.bak and mtime are exists on current directory"
    exit 1
fi

# 本地vim配置文件
vim_src="~/.vimrc"
# 备份文件
vim_bak="./vimrc.bak"

# 上一次执行脚本时的modification time
read old_time < ./mtime
old_time_human=`sed -n 2p ./mtime`
# old_time_human=`date -d @$old_time`
echo "The old modification time is $old_time_human"

# vim配置文件当前的modification time
new_time=`stat -c %Y ~/.vimrc`
new_time_human=`stat -c %y ~/.vimrc`
echo "The new modification time is $new_time_human"

if [ $new_time -gt $old_time ]; then
    echo "The new modification time more near"
    diff $vim_src $vim_bak >> /dev/null
    if [ $? -ne 0 ]; then
        echo "The .vimrc file updated, will auto backup"
        cp -f $vim_src $vim_bak
        if [ $? -eq 0 ]; then
            echo 'Congratulations! vimrc update success'
            echo `date +%s` > ./mtime
            echo `date` >> ./mtime
        fi
    else
        echo "vimrc.bak already latest version"
    fi
else
    echo "$new_time(.vimrc) <= $old_time(vimrc.bak), nothing to do"
fi
