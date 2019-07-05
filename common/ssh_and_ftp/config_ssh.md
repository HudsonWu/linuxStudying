# 配置文件

```
man sshd_config
```

## /etc/ssh/sshd_config
```
> chmod 700 .ssh
//密码验证
PermitRootLogin yes
PasswordAuthentication yes
//秘钥对验证
RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
(需要在.ssh/authorized_keys加入公钥)
> chmod 644 .ssh/authorized_keys
//监听多个端口
ListenAddress 0.0.0.0:22
ListenAddress 0.0.0.0:181
```

## .ssh/config文件, 管理多个私钥
```
Host 192.168.0.*
IdentityFile ~/.ssh/id2_rsa
User root

Host github.com
IdentityFile ~/.ssh/id_rsa
User HudsonWu
```

## 限制IP和用户通过ssh登录Linux

1. hosts.allow, hosts.deny
/etc/hosts.allow
```
sshd:192.168.1.2:allow  //允许特定ip
sshd:192.168.1.0/24:allow  //允许特定ip地址段
```
/etc/hosts.deny
```
sshd:ALL
```

2. iptables
```
> iptables -A INPUT -p tcp -s 192.168.1.2 --destination-port 22 -j ACCEPT
> iptables -A INPUT -p tcp --destination-port 22 -j DROP
```

3. sshd.config
```
allowusers xxx@192.168.1.2
```

