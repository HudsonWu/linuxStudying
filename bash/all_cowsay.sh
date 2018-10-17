#!/bin/bash

# 使用/usr/share/cowsay下的cowfile
# 匀速遍历打印出fortune命令的随机文字

a=`ls /usr/share/cowsay`

OLD_IFS="$IFS" 

# 将字符串根据分隔符取出到数组中
IFS=" " 
arr=($a)

IFS="$OLD_IFS"

for s in ${arr[@]} 
do
    # 字符串匹配 
    if echo $s | grep cow
    then
        fortune | cowsay -f $s
        echo -e "\n"
        sleep 2
    fi
done
