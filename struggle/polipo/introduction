1. 安装
apt-get polipo
2. 配置
停止服务：service polipo stop
配置文件：/etc/polipo/config
socksParentProxy = "localhost: 1080"
socksProxyType = socks5
proxyPort = 3128
启动服务：servece polipo start
3. 使用
app里配置http_proxy=http://127.0.0.1:3128
bash里编辑$HOME/.bashrc，添加export http_proxy=http://127.0.0.1:3128
git配置，git config --global http.proxy 127.0.0.1:3128
4. 测试
curl ip.gs
