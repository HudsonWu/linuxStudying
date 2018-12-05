#!/bin/sh

#
# Filename: filesize.sh
# Description: 根据文件大小判断接下来的操作
# Author: HudsonWu
# Email: wuhaishui1234@gmail.com
# Revision: 0.1
# Date: 2017-12-11
# Note: test
#

filename=media.log
filesize=`ls -l $filename | awk '{ print $5 }'`
maxsize=$((1024*10))

if [ $filesize -gt $maxsize ]
then
    echo "$filesize > $maxsize"
    mv media.log media"`date +%Y-%m-%d_%H:%M:%S`".log
else 
    echo "$filesize < $maxsize"
fi
