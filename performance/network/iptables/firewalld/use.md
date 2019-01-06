## 区域管理

```
//显示支持的区域列表
firewall-cmd --get-zones
//设置为家庭区域
firewall-cmd --set-default-zone=home
//查看当前区域
firewall-cmd --get-active-zones
//设置当前区域的接口
firewall-cmd --get-zone-of-interface=enp0s3
//显示公共区域(public)所有项
firewall-cmd --zone-public --list-all
//临时修改网络接口enp0s3为内部区域
firewall-cmd --zone=internal --change-interface=enp0s3
//永久修改网络接口enp0s3为内部区域
firewall-cmd --permanent --zone=interval --change-interface=enp0s3
```

## 服务管理

```
//显示服务列表
firewall-cmd --get-services
//允许ssh服务通过
firewall-cmd --enable service=ssh
//禁止ssh服务通过
firewall-cmd --disable service=ssh
//临时允许samba服务通过600s
firewall-cmd --enable service=samba --timeout=600
//显示当前服务
firewall-cmd --list-services
//添加http服务到内部区域
firewall-cmd --permanent --zone=internal --add-service=http
firewall-cmd --reload
//将一个服务加入到分区
firewall-cmd --zone=work --add-service=smtp
firewall-cmd --reload
//从分区移除服务
firewall-cmd --zone=work --remove-service=smtp
firewall-cmd --reload
```

## 端口管理

```
//打开端口
firewall-cmd --zone=internal --add-port=443/tcp
firewall-cmd --reload
//端口转发
firewall-cmd --zone=external --add-masquerade
firewall-cmd --zone=external --add-forward-port=port=22:proto=tcp:toport=3777
```

# 配置指定网段访问ssh

```
//移除ssh服务
firewall-cmd --zone=dmz --remove-service=ssh --permanent
//添加指定网段对ssh所用的端口访问权限
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.0.0/24" port protocol="tcp" port="22" accept'
```
