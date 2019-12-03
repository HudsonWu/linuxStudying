#!/bin/bash

# 定期监控服务运行状况
while true
do
    header=`curl -I http://example:4873`
    if [[ $header =~ 'HTTP/1.1 200 OK' ]]; then
        echo 'ok';
    else
        # 重启服务
        nohup verdaccio &
    fi
    # 每个10秒检查一次
    sleep 10s
done
