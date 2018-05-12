#!/bin/bash
# Epoch 新纪元

# 定义本地vim配置文件.vimrc
vim_src="/home/hudson/.vimrc"
# 定义备份文件vimrc
vim_bak="./vimrc"
# 定义上一次备份时的文件更新时间
read old_time < ./mtime
# 定义文件最近更新时间
new_time=`stat -c %Y /home/hudson/.vimrc`

old_time_human=`sed -n 2p ./mtime`
# old_time_human=`date -d @$old_time`
echo "The old update time is $old_time_human"
new_time_human=`stat -c %y /home/hudson/.vimrc`
echo "The new update time is $new_time_human"

# 判断是否有更新
if [ $new_time -gt $old_time ]; then
    cp -f $vim_src $vim_bak
    echo $new_time > ./mtime
    echo $new_time_human >> ./mtime
    echo 'Congratulations! vimrc update success'
else
    echo 'vimrc already latest version, nothing to do'
fi

