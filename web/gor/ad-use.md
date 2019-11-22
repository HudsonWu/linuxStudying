# Gor高级用法

```
# 转发到多个地址
gor --input-tcp :28020 --output-http "http://staging.example.com" --output-http "http://qa.example.com"

# 分发流量
## 默认gor会将同样的流量复制到所有输出
## 使用--split-output选项可以平均分发(round-robin)流量
gor --input-raw :80 --output-http "http://staging.example.com" --output-http "http://qa.example.com" --split-output true

# 跟踪响应流量
## 默认input-raw不会拦截响应流量
## 可以使用--input-raw-track-response选项开启响应流量的拦截

# 流量拦截引擎
## Gor默认使用libpcap拦截流量，也可以使用另一个可选的引擎：raw_socket
gor --input-raw :80 --input-raw-engine "raw_socket" --output-http "http://qa.example.com"

# 可以使用--input-raw-realip-header选项指定header
gor --input-raw :80 --input-raw-realip-header "X-Real-IP" ...
```
