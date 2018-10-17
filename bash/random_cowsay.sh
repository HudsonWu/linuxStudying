#!/bin/bash

# 随机使用/usr/share/cowsay/cows下的cowfile
# 显示出fortune命令下的文字

# IFS (Internal Field Separator), 默认为space/tab/new line, 可以指定分隔符
# IFS=:
# IFS=: read -r -a DIRS <<< "$PATH"

# cowfiles=$(ls /usr/share/cowsay/cows)

# read -a cowfile_array <<< $cowfiles
# echo $cowfiles | cut -d ' ' -f 2
# echo $cowfiles | awk '{print $2}'

len=`ls /usr/share/cowsay/cows | grep cow | wc | awk '{print $1}'`

# 生成随机数
function rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(date +%s%N)
    echo $(($num%$max+$min))
}

num=$(rand 1 $len)

cowfiles=`ls /usr/share/cowsay/cows | grep cow`
cowfile=`echo $cowfiles | cut -d ' ' -f $num` 

echo "$num  $cowfile"
fortune | cowsay -f $cowfile

exit 0
