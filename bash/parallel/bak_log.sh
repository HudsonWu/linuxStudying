#!/bin/bash

# 当前日期
date=`date +"%Y-%m-%d"`

# 日志文件所在路径
log_path="/path/storage/logs"

file="$log_path/laravel.log"
# 文件大小
filesize=`ls -l $file | awk '{ print $5 }'`

# 设置文件最大值
maxsize=$((1024*1024*20))

if [ $filesize -gt $maxsize ]; then
    cp -f $file $log_path/old_laravel_logs/laravel_$date.log
    true > $file
fi

