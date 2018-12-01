## 邮件配置

> https://www.zhangluya.com/?p=602


### 腾讯企业邮箱(1)

> yum install -y mailx <br/>

> vim /etc/mail.rc <br/>
```
set bsdcompat
set from=monitor@zhangluya.com
set smtp=smtp.exmail.qq.com
set smtp-auth-user=monitor@zhangluya.com
set smtp-auth-password=xxxxxx
set smtp-auth=login
```

//邮件发送方式<br/>
> echo "这是一个测试腾讯企业邮箱调用测试邮件"|mail -s "Tencent 企业邮件" zhangluya@zhangluya.com <br/>

### 网易163企业邮箱(2)

> vim /etc/mail.rc <br/>
```
set bsdcompat
set from=monitor@zhangluya.com
set smtp=smtp.qiye.163.com
set smtp-auth=login
set smtp-auth-user=monitor@zhangluya.com
set smtp-auth-password=xxxx # 此处为客户端授权码 需要去网易企业邮箱单独设置
```

//邮件发送方式<br/>
> echo "这是一个测试163企业邮箱调用测试邮件"|mail -s "163 企业邮件" zhangluya@zhangluya.com <br/>

### 25端口禁用时 

因为阿里云封禁了默认的25端口导致(1)、(2)配置方式不可用<br/>
这里可以使用smtps ssl加密替代<br/>

腾讯企业邮箱配置方式<br/>
```
mkdir ~/.certs
certutil -N -d ~/.certs
echo -n|openssl s_client -connect smtp.exmail.qq.com:465|sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ~/.certs/qq.crt
certutil -A -n "tencent qiye mailbox" -t "C,," -d ~/.certs -i ~/.certs/qq.crt
cd .certs/
certutil -A -n "GeoTrust SSL CA - G3" -t "Pu,Pu,Pu" -d ./ -i qq.crt
```

> vim /etc/mail.rc <br/>
```
set nss-config-dir=/root/.certs
set ssl-verify=ignore
set smtp=smtps://smtp.exmail.qq.com:465
set smtp-auth=login
set smtp-auth-user=dev@xxx.net
set smtp-auth-password=xxx
set from=dev@xx.net
```

网易企业邮箱配置方式<br/>
```
mkdir ~/.certs
certutil -N -d ~/.certs
echo -n|openssl s_client -connect smtp.qiye.163.com:465|sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ~/.certs/163.crt
certutil -A -n "163 qiye mailbox" -t "C,," -d ~/.certs -i ~/.certs/163.crt
cd .certs/
certutil -A -n "GeoTrust SSL CA - G3" -t "Pu,Pu,Pu" -d ./ -i 163.crt
```

> vim /etc/mail.rc <br/>
```
set bsdcompat
set ssl-verify=ignore
set smtp-user-starttls
set nss-config-dir=/root/.certs
set from=monitor@xx.com
set smtp=smtps://smtp.qiye.163.com:465
set smtp-auth=login
set smtp-auth-user=monitor@xx.com
set smtp-auth-password=xx
```
