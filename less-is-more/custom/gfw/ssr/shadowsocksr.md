后台运行:
 python server.py -p 46176 -k qSlzBU -m aes-256-cfb -O auth_sha1_v4 -o tls1.2_ticket_auth -d start
停止/重启:
python server.py -d stop/restart
查看日志:
tail -f /var/log/shadowsocksr.log

