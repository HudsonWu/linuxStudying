# iptables之nf_conntrack模块

## 常用命令

```
# 查看nf_conntrack表当前连接数
cat /proc/sys/net/netfilter/nf_conntrack_count

# 查看nf_conntrack表最大连接数
cat /proc/sys/net/netfilter/nf_conntrack_max

# 通过dmesg可以查看nf_conntrack的状况
dmesg | grep nf_conntrack

# 查看存储conntrack条目的哈希表大小, 此为只读文件
cat /proc/sys/net/netfilter/nf_conntrack_buckets

# 查看nf_conntrack的TCP连接记录时间
cat /proc/sys/net/netfilter/nf_conntrack_tcp_timeout_established

# 通过内核参数查看命令, 查看所有参数配置
sysctl -a | grep nf_conntrack

# 通过conntrack命令行工具查看conntrack的内容
yum install -y conntrack
conntrack -L

# 加载对应跟踪模块
modprobe /proc/net/nf_conntrack_ipv4
lsmod | grep nf_conntrack

# 移除nf_conntrack模块
modprobe -r xt_NOTRACK nf_conntrack_netbios_ns nf_conntrack_ipv4 xt_state
modprobe -r nf_conntrack

# 查看当前的连接数
grep nf_conntrack /proc/slabinfo

# 查出目前nf_conntrack的排名
cat /proc/net/nf_conntrack | cut -d ' ' -f 10 | cut -d '=' -f 2 | sort | uniq -c | sort -nr | head -n 10
```
