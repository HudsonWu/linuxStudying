#!/bin/bash
### BEGIN INIT INFO
# Provides:		ssr
# Required-Start	$remote_fs
# Default-Start:	2 3 4 5
# Short-Description: Start the shadowsocksr proxy
# Description:		This script controls start ssr proxy
#					It is called from the boot, halt and reboot scripts.
### END INIT INFO
#
# Author: Hudson Wu

NAME=ssr
SSRPATH=/usr/local/src/shadowsocksr/shadowsocks

case "$1" in
	start)
		python ${SSRPATH}/local.py -c ${SSRPATH}/conf-json/hk2.json &
		echo  "Starting ${NAME} OK"
		;;
	stop)
		echo "Stopping ${NAME} Failed(need do it manually)"
		;;
	status)
		echo "Please check the status manually"
		;;
esac

exit 0