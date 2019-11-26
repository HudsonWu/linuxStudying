# 限制

## rate limiting, 速率限制

有两种策略，一是随机丢弃请求；二是根据Header或者Url参数删除部分请求。

## Dropping random requests, 随机丢弃请求

有两种策略，一是Absolute，每一秒达到指定的请求限制数量时，丢弃剩余的；二是Percentage，对于input-file，将减慢或加快请求执行的速度，对于其他输入方式，将随机决定请求通过或丢弃。

```
# 使用绝对数量
# 限制每秒的最大请求数为10个
gor --input-tcp :28020 --outpt-http "http://staging.com|10"

# 使用百分比
# 复制不超过10%的请求
gor --input-raw :80 --output-tcp "replay.local:28020|10%"
```

## Consistent limiting based on Header or URL param value, 根据Header或者Url参数持续筛选请求

```
# 根据header筛选
gor --input-raw :80 --output-tcp "replay.local:28020|10%" --http-header-limiter "X-API-KEY: 10%"

# 根据url参数筛选
gor --input-raw :80 --output-tcp "replay.local:28020|10%" --http-param-limiter "api_key: 10%" ```
```
