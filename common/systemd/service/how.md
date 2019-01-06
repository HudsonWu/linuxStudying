## 给程序设置systemd

创建文件: /etc/systemd/system/websocks.service, 内容如下<br/>
```
[Unit]
Description=websocks

[Service]
ExecStart=/usr/local/websocks/websocks server -l 127.0.0.1:8080 -p /path
Restart=always

[Install]
WantedBy=multi-user.target
```
