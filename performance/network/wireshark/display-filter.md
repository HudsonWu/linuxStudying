# 显示过滤

```
# 延迟确认包
tcp.analysis.ack_rtt > 0.2 and tcp.len == 0

# 握手失败的包 (启用Relative Sequence Number)
(tcp.flags.reset == 1) && (tcp.seq == 1)
(tcp.flags.syn == 1) && (tcp.analysis.retransmission)
```
