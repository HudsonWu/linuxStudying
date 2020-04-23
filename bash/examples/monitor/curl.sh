#!/bin/sh

# 定期监控服务运行状况
# 执行nohup sh monitor.sh &启动守护进程

# 获取脚本目录
shell_folder=$(cd `dirname $0`; pwd)

while true
do
    header=`curl --connect-timeout 5 -X GET -I http://example:4873`

    if [ $? -ne 0 ] && [[ $header =~ 'HTTP/1.1 200 OK' ]]; then
        echo 'ok';
    else
        # 重启服务并记录日志
        nohup verdaccio &
        echo `date +%Y-%m-%d\ %H:%M:%S` "restart" >> $shell_folder/verdaccio.restart.log
    fi

    # 每隔10秒检查一次
    sleep 10s
done

# 直接获取状态码
curl -sL -w "%{http_code}" --connect-timeout 10 -I -X GET http://example:4873 -o /dev/null
