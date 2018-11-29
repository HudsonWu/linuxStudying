# 配置指定网段访问ssh

1. 移除ssh服务
firewall-cmd --zone=dmz --remove-service=ssh --permanent
2. 添加指定网段对ssh所用的端口访问权限
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.0.0/24" port protocol="tcp" port="22" accept'
