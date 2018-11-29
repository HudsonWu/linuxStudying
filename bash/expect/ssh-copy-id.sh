#!/bin/bash

# 截取第2列以DH开头的行，并输出第二列
hosts=`awk '$2~/^DH/{print $2}' /etc/hosts`

for host in $hosts;do
    ./ssh-copy-id.exp $host         # 调用expect脚本
done
