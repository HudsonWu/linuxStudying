#!/bin/bash

# /usr/share/cowsay/cows
# cowsay -f
# 依次使用所有的cowfile打印显示出fortune命令下的文字

cowfiles=`ls /usr/share/cowsay/cows`

for s in ${cowfiles[@]} 
do
    # 字符串匹配 
    if echo $s | grep cow
    then
        fortune | cowsay -f $s
        echo -e "\n"
        sleep 2
    fi
done
