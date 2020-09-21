# ab, http服务压测

ab, apache bench, 是针对HTTP服务进行性能压力测试的工具，最初被设计用来测量Apache服务器的性能指标，主要用来测试Apache服务器每秒能够处理多少请求以及响应时间，也可以用来测试通用HTTP服务器性能。

ab只能测试简单的RESTful接口，只能应付简单的压测任务，如果需要更加专业的压测工具可以使用jmeter。

## 安装

```
# CentOS
yum install -y httpd-tools

# Debian
apt install -y apache2-utils
```

## 使用

```
ab -c 10 -n 10000 -k -H "Accept-Encoding: gzip, deflate" http://localhost:8080/

# -c concurrency 并发数
# -n requests 一次测试请求数量
# -k, keep alive, 保持连接
# -H headers 自定义header

# 验证Cookie
ab -n 100 -C key=value http://localhost
ab -n 100 -H "Cookie: key1=Value1; key2=Value2" http://localhost
```

```
ab -n 100 -c 10 http://www.yahoo.com/

ab -n 100 -c 10 http://127.0.0.1:8300/test.php > test1.txt &
ab -n 100 -c 10 http://127.0.0.1:8300/tes2t.php > test2.txt &
```

### post

```
-p means to POST it
-H adds an Auth header (could be Basic or Token)
-T sets the Content-Type
-c is concurrent clients
-n is the number of requests to run in the test
```

#### x-www-form-urlencoded

```
# post_loc.txt
name=chang&password=11111ok

ab -p post_loc.txt -T application/x-www-form-urlencoded -c 10 -n 2000 http://example.com/test
```

#### json

```
# test.json
{"timestamp" : 1484825894873, "test" : "test"}

ab -c 10 -n 1000 -p  test.json -T application/json https://example.com/test
```

## 报错处理

```
报错内容：
apr_pollset_poll: The timeout specified has expired (70007)

原因：
timeout，连接超时了

解决方法：
可以加个-k参数，让连接keepalive
另外还有-r和-s参数也可以加上
-r  Don't exit on socket receive errors, 在遇到socket接收错误后，不退出测试
-s timeout  Seconds to max. wait for each response, 最大超时时间， 默认30s
-k  Use HTTP KeepAlive feature
```

```
报错内容：
apr_socket_recv: Connection reset by peer (104)

原因：
当ab遇到严重的网络错误后，就会退出测试，因为这种错误说明网络存在其他问题，
但是只要服务器返回数据，哪怕是数据不对，ab也会继续下去，但是会记录数据长度
不对。但事实是：在高压力下，偶尔的一两个请求被阻止，这是一个正常的情况，
特别是有防火墙或侵入检测系统的情况下，这种事情会经常发生。

解决方法：
-r参数可以实现忽略这种错误
```
