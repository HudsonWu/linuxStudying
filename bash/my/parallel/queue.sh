#!/bin/bash

if [ $# -eq 1 ]; then
    echo "$1下的队列已开启"
    cd $1 && php artisan queue:work redis --sleep=3 --tries=3
else
    echo "Usage:"
    echo "$0 [需要开启队列的php目录]"
    echo "Example:"
    echo "$0 /home/phpformobile"
    #echo -e "\n---- 未指定目录, 将开启默认目录下的队列 ----\n"
    #cd /home/phpformobile && php artisan queue:work redis --sleep=3 --tries=3
fi

