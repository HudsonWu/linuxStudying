1. 安装

```
//postfix
yum install postfix mailx cyrus-sasl-*
systemctl start postfix.service

//附件软件包
yum install sharutils

//检查
netstat -tunlp | grep 25
```

2. 配置

/etc/postfix/main.cf (postfix主要配置文件)<br/>
```
//指定默认的邮件发送服务器
relayhost = [smtp.163.com]:25
//激活sasl认证
smtp_sasl_auth_enable = yes
//指定sasl密码配置文件
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
//非匿名登录
smtp_sasl_security_options = noanonymous
//指定认证类型, 需要安装cyrus-sasl-*组件
smtp_sasl_type = cyrus
//linux用户与发件人的对应关系配置文件
sender_canonical_maps = hash:/etc/postfix/sender_canonical
```

/etc/postfix/sasl_passwd <br/>
```
//(邮箱账号和密码文件, 每行一个, 创建好后, 使用postmap命令使配置文件生效)
> [smtp.163.com]:25 example@163.com:my163password
postmap /etc/postfix/sasl_passwd
```

/etc/postfix/sender_canonical <br/>
```
//(linux用户和发件人对应关系, 每行一个)
> root example@163.com
postmap /etc/postfix/sender_canonical
```

3. 重启
> systemctl restart postfix

4. 发送邮件
> echo "hello world" | mail -s test other@qq.com <br/>
可以使用mailq命令查看发送队列, 清空mailq队列: postsuper -d ALL

5. 一些命令
> mailq  //查看队列邮件<br/>
> postsuper -d ALL  //删除所有邮件<br/>
