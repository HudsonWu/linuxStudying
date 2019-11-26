# http流量复制

Gor使用--output-http选项复制http流量。

Gor默认会创建一个动态worker池，从10个worker开始，当输出队列长度大于10时，会创建更多的HTTP输出worker，创建的worker数量等于当时检测到的队列长度减去10得到的值，每一次有消息写到HTTP输出队列时就会检查一次队列长度。你可以使用选项`--output-http-workers=20`指定worker数量。

默认Gor会忽略重定向，你可以像下面的命令一样启用重定向：
```
# 每个请求跟踪最多两级重定向
gor --input-tcp replay.local:28020 --output-http http://staging.com --output-http-redirects 2
```

默认http请求和http响应的超时时间为5秒，可以像下面的命令一样自定义：
```
gor --input-tcp replay.local:28020 --output-http http://staging.com --output-http-timeout 30s
```

默认情况下，为了较少内存消耗，内部HTTP客户端将获取最大200kb的Response body，可以使用`--output-http-response-buffer`选项自定义。

如果你的应用接收来自多个域名的流量，并且你想保留original headers，可以指定`--http-origin-host`。
