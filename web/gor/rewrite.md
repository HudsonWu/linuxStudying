# 请求重写

```
# 基于映射重写
gor --input-raw :8080 --output-http staging.com --http-rewrite-url \
    /v1/user/([^\\/]+)/ping:/v2/user/$1/ping

# 设置URL参数，参数存在时会被覆盖
gor --input-raw :8080 --output-http staging.com --http-set-param api_key=1

# 设置Header，存在是会被覆盖
gor --input-raw :80 --output-http "http://staging.server" \
    --http-header "User-Agent: Replayed by Gor" \
    --http-header "Enable-Feature-X: true"
```

HTTP Header中Host比较特殊，默认Host的值是--output-http指定的站点，使用--http-header设置无效，如果要保持源Host值，可以使用选项`--http-original-host`。
