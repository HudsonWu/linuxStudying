# 请求过滤

可以通过URL、HTTP Header或者HTTP Method对请求进行过滤。

## 通过URL过滤，支持正则表达式

```
# 只转发/api的请求
gor --input-raw :8080 --output-http staging.com --http-allow-url /api

# 不转发/api的请求
gor --input-raw :8080 --output-http staging.com --http-disallow-url /api
```

## 通过header过滤，支持正则表达式

```
# 仅转发header中api-version为1.0x的请求
gor --input-raw :8080 --output-http staging.com --http-allow-header api-version:^1\.0\d

# 不转发header中User-Agent为Replayed by Gor的请求
gor --input-raw :8080 --output-http staging.com --http-disallow-header "User-Agent: Replayed by Gor"
```

## 通过HTTP Method过滤

```
gor --input-raw :80 --output-http "http://staging.com" \
    --http-allow-method GET \
    --http-allow-method OPTIONS
```
