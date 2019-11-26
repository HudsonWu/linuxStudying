# 分布式配置

有时，使用单独的Gor实例来复制流量执行负载测试之类的任务是很有意义的。这样，生产环境就不会浪费宝贵的资源，可以在web应用服务器配置Gor，将流量转发到独立服务器上的Gor aggregator实例。

```
# 在你想要抓取流量的服务器上运行
gor --input-raw :80 --output-tcp replay.local:28020

# replay server
gor --input-tcp replay.local:28020 --output-http http://staging.com
```

如果配置了多台replay server可以使用`--split-output`选项，它将使用round robin算法平均分流到所有输出：
```
gor --input-raw :80 --split-output --output-tcp replay1.local:28020 --output-tcp replay2.local:28020
```
