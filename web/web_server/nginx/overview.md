# nginx

一款轻量级的web服务器/反向代理服务器及电子邮件(IMAP/POP3)代理服务器

占用内存少, 并发能力强

## 特点

1. 处理静态文件, 索引文件以及自动索引; 打开文件描述符缓冲
2. FastCGI, 简单的负载均衡和容错
3. 模块化的结构, 包括gzipping, byte ranges, chunked responses以及SSI-filter等filter
如果由FastCGI或其他代理服务器处理单页中存在的多个SSI, 则这项处理可以并行运行, 而不需要相互等待
4. 支持SSL和TLSSNI

## Nginx架构

nginx启动后, 会有一个master进程和多个worker进程, master进程的主要目的是读取和评估配置, 并维护worker进程, worker进程对请求进行处理. nginx采用了基于事件模型和依赖于操作系统的机制来有效地在工作进程之间分配请求.

master进程主要用来管理worker进程, 功能包含:
1. 接收来自外界的信号, 向各worker进程发送信号
2. 监控worker进程的运行状态, 当worker进程退出后(异常情况下), 自动重新启动新的worker进程

基本的网络事件, 由worker进程来处理, 多个worker进程之间是对等的, 各进程间相互独立, worker进程的个数可以设置, 一般设置与机器CPU核数一致

## 启动、停止和重新加载配置

要启动nginx, 直接运行可执行文件

nginx启动之后, 可以通过运行可执行文件附带-s参数来对nginx进行控制
```
nginx -s 信号
```

信号可能是以下之一:
+ stop, 立即关闭
+ quit, 正常关闭(等待工作进程处理完当前请求才停止nginx进程)
+ reload, 重新加载配置文件
+ reopen, 重新打开日志文件

一旦master进程收到要重新加载配置(reload)的信号, 它将检查新配置文件语法的有效性, 并尝试应用其中提供的配置. 如果成功, 主进程将启动新的worker进程, 并向旧worker进程发送消息, 请求它们关闭. 否则, 主进程回滚更改, 并继续使用旧配置. 旧worker进程接收到关闭命令后, 停止接收新的请求连接, 并继续维护当前请求, 直到这些请求都被处理完成之后, 旧worker进程将退出

## 命令行参数

```
-?, -h    打印帮助信息
-c file    使用指定的配置文件
-g directive    设置全局配置指令, 如
  > nginx -g "pid /var/run/nginx.pid; worker_processes `sysctl -n hw.ncpu`;"
-p prefix    设置nginx路径前缀
-q    在配置测试期间禁止非错误信息
-s signal    向master进程发送信号
-t    测试配置文件; nginx检查配置文件的语法正确性
-T    与-t一样, 另外会将配置文件输出到标准输出
-v    打印nginx版本
-V    打印nginx版本, 编译器版本和配置参数
```
