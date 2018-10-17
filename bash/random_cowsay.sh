#!/bin/bash

# 随机使用/usr/share/cowsay下的cowfile
# 打印出fortune命令的随机文字

a=`ls /usr/share/cowsay`

OLD_IFS="$IFS" 

# 将字符串根据分隔符取出到数组中
IFS=" " 
arr=($a)

IFS="$OLD_IFS"

len=${#arr[*]}

# 生成随机数
function rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(date +%s%N)
    echo $(($num%$max+$min))
}

rnd=$(rand 0 $((len-1)))

echo $arr
echo $len
#fortune | cowsay -f ${arr[$rnd]}

exit 0
