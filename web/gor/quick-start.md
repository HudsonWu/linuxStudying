# 快速上手

## 安装

根据你的操作系统从[github](https://github.com/buger/goreplay/releases)下载编译好的二进制包，
比如liunx环境，下载gor_1.0.0_x64.tar.gz，然后解压出二进制可执行文件gor，将gor文件复制到/usr/bin。

## 简单使用

### 抓取web流量

```
# 快速启动一个文件服务器
gor file-server :8000

# 监听指定端口的http请求并输出到标准输出
gor --input-raw :8000 --output-stdout

# 默认gor不跟踪http响应
# 可以使用--output-http-track-response启用
```

### 复制流量

```
# 抓取到请求后直接复制到另一个站点
gor --input-raw :8000 --output-http="http://qa.example.com"

# 先保存请求到文件再复制到另一个站点
gor --input-raw :8000 --output-file=requests.gor
gor --input-file requests.gor --output-http="http://qa.example.com"
```
