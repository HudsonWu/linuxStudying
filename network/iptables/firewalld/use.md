# 区域管理

1. 显示支持的区域列表
> firewall-cmd --get-zones
2. 设置为家庭区域
> firewall-cmd --set-default-zone=home
3. 查看当前区域
> firewall-cmd --get-active-zones
4. 设置当前区域的接口
> firewall-cmd --get-zone-of-interface=enp0s3
5. 显示公共区域(public)所有项
> firewall-cmd --zone-public --list-all
6. 临时修改网络接口enp0s3为内部区域
> firewall-cmd --zone=internal --change-interface=enp0s3
7. 永久修改网络接口enp0s3为内部区域
> firewall-cmd --permanent --zone=interval --change-interface=enp0s3


# 服务管理

1. 显示服务列表
> firewall-cmd --get-services
2. 允许ssh服务通过
> firewall-cmd --enable service=ssh
3. 禁止ssh服务通过
> firewall-cmd --disable service=ssh
4. 临时允许samba服务通过600s
> firewall-cmd --enable service=samba --timeout=600
5. 显示当前服务
> firewall-cmd --list-services
6. 添加http服务到内部区域
> firewall-cmd --permanent --zone=internal --add-service=http
> firewall-cmd --reload
7. 将一个服务加入到分区
> firewall-cmd --zone=work --add-service=smtp
> firewall-cmd --reload
8. 从分区移除服务
> firewall-cmd --zone=work --remove-service=smtp
> firewall-cmd --reload


# 端口管理

1. 打开端口
> firewall-cmd --zone=internal --add-port=443/tcp
> firewall-cmd --reload
2. 端口转发
> firewall-cmd --zone=external --add-masquerade
> firewall-cmd --zone=external --add-forward-port=port=22:proto=tcp:toport=3777

