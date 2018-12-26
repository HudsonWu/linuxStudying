#!/bin/bash
### BEGIN INIT INFO
# Provides:             ssr
# Required-Start        $remote_fs
# Required-Stop         $remote_fs
# Default-Start:        2 3 4 5
# Default-Stop:         0 1 6
# Short-Description:    Start or Stop the shadowsocksr proxy
# Description:          This script controls the ssr proxy
#                       It is called from the boot, halt and reboot scripts.
### END INIT INFO
#
# Author: Hudson Wu

SSR_PATH=/usr/local/src/shadowsocksr/shadowsocks
test -x $SSR_PATH || exit 0

# CONFIG_FILE=$SSR_PATH/conf-json

NAME=ssr

start(){
    if pgrep -f "shadowsocksr" > /dev/null; then
        echo "$NAME already running -- doing nothing"
        exit
    fi
    # python ${SSR_PATH}/local.py -c ${CONFIG_FILE}/us1.json &
    /usr/local/bin/ssr-local
    if [ $? -ne 0 ]; then
        echo "ERROR: start $NAME failed"
        exit 1
        else
        echo "Congratulations, $NAME start success"
    fi
}

stop(){
    if ! pgrep -f "shadowsocksr" > /dev/null; then
        echo "$NAME not running -- doing nothing"
        exit
    fi
    SSR_PID=`pgrep -f shadowsocksr`
    kill -9 $SSR_PID
    if [ $? -ne 0 ]; then
        echo "ERROR: stop $NAME failed"
    else
        echo "$NAME stop success"
    fi
}

status(){
    if pgrep -f "shadowsocksr" > /dev/null; then
        SSR_PID=`pgrep -f shadowsocksr`
        echo "$NAME is running, pid is $SSR_PID"
    else
        echo "$NAME isn't running"
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    status)
        status
        ;;
    *)
        echo "invalid argument, please use start|stop|restart|status"
esac

exit 0