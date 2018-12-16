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

nginx启动后, 会有一个master进程和多个worker进程

master进程主要用来管理worker进程, 功能包含:
1. 接收来自外界的信号, 向各worker进程发送信号
2. 监控worker进程的运行状态, 当worker进程退出后(异常情况下), 自动重新启动新的worker进程
基本的网络事件, 由worker进程来处理, 多个worker进程之间是对等的, 各进程间相互独立, worker进程的个数可以设置, 一般设置与机器CPU核数一致
