#!/bin/bash

# 定义一个工具函数
function pgset() {
    local result
    echo $1 > $PGDEV

    result=`cat $PGDEV | fgrep "Result: OK:"`
    if [ "$result" = "" ]; then
        cat $PGDEV | fgrep Result:
    fi
}

# 为0号线程绑定eth0网卡
PGDEV=/proc/net/pktgen/kpktgend_0
pgset "rem_device_all"  # 清空网卡绑定
pgset "add_device eth0"  # 添加eth0网卡

# 配置eth0网卡的测试选项
PGDEV=/proc/net/pktgen/eth0
pgset "count 1000000"  # 总发包数量
pgset "delay 5000"  # 不同包之间的发送延迟，单位为纳秒
pgset "clone_skb 0"  # SKB包复制
pgset "pkt_size 64"  # 网络包大小
pgset "dst 192.168.19.51"  # 目的IP
pgset "dst_mac 00:16:3e:10:24:b5"  # 目的MAC

# 启动测试
PGDEV=/proc/net/pktgen/pgctrl
pgset "start"

