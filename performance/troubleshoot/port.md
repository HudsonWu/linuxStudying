# 检查端口是否被占用

## 检查监听的端口和应用

```
lsof -i -P -n | grep LISTEN
netstat -tulpn | grep LISTEN
ss -tulw
ss -tulwn
lsof -i:22
nmap -sTU ip-address-here
```
