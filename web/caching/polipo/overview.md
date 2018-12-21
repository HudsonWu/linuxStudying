# polipo

polipo是一个小而快速的缓存web代理程序(web 缓存, HTTP代理, 代理服务器)


## 代理服务器

1. 配置
```
停止服务：service polipo stop
配置文件：/etc/polipo/config
socksParentProxy = "localhost: 1080"
socksProxyType = socks5
proxyPort = 3128
启动服务：servece polipo start
```

2. 使用
```
app里配置http_proxy=http://127.0.0.1:3128
bash里编辑$HOME/.bashrc，添加export http_proxy=http://127.0.0.1:3128
git配置，git config --global http.proxy 127.0.0.1:3128
```

3. 测试
```
curl ip.gs
```
