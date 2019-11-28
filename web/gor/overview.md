# Gor工具的用法

Gor的设计理念遵循UNIX哲学：一切皆管道，多路输入到输出。你可以对请求速率进行限制(rate limit)、过滤请求(filter)、重写请求(rewrite)，甚至使用中间件实现自定义的逻辑。

## 可用的输入选项

+ `--input-raw`, 抓取HTTP流量，指定ip地址或网卡接口以及应用端口
+ `--input-file`, 从文件中读取请求
+ `--input-tcp`, 聚合转发流量
+ `--input-raw-track-response`, 抓取origin response

## 可用的输出选项

+ `--output-http`, 复制http流量到给定地址
+ `--output-file`, 记录流量到文件
+ `--output-tcp`, 与`--input-tcp`一起使用，转发流量到另一个Gor实例
+ `--output-stdout`, 用于调试，输出到标准数据
+ `--output-http-track-response`, 抓取replay response
