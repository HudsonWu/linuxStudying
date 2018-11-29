# firewalld是iptables的前端控制器, 用于实现持久的网络流量规则
1. firewalld使用区域和服务而不是链式规则
2. 它动态管理规则集, 允许更新规则而不破坏现有会话和连接

# 基础命令
检查防火墙动态
> firewall-cmd --state
重新加载配置
> firewall-cmd --reload
允许或者拒绝任意端口/协议
> firewall-cmd --zone=public --add-port=12345/tcp --permanent
> firewall-cmd --zone=public --remove-port=12345/tcp --permanent

# 配置firewalld
firewalld使用XML进行配置, 除非是非常特殊的配置, 你不必处理它们, 应该使用firewall-cmd
配置文件目录:
/usr/lib/firewalld  默认配置, 如默认区域和公用服务, 避免修改它们, 每次firewall软件包更新都会覆盖这些文件
/etc/firewalld  系统配置文件, 覆盖默认配置
配置集:
"运行时"  系统重新启动或firewalld重启时, 不会保留运行时的配置更改
"持久"    持久配置的更改不会应用于正在运行的系统
默认情况下, firewall-cmd命令适用于运行时配置, 使用--permanent标志保存到持久配置中
1. 将规则同时添加到持久规则集和运行时规则集中
> firewall-cmd --zone=public --add-service=http --permanent
> firewall-cmd --zone=public --add-service=http
2. 将规则添加到持久规则集中并重新加载firewalld
> firewall-cmd --zone=public --add-service=http --permanent
> firewall-cmd --reload
reload命令会删除所有运行时配置并应用永久配置, 因为firewalld动态管理规则集, 所以不会破坏现有的连接和会话

# 防火墙的区域
"区域"是针对给定位置或场景(如家庭、公共、受信任等)可能具有的各种信任级别的预构建规则集
不同的区域允许不同的网络服务和入站流量类型, 而拒绝其他任何流量
首次启动firewalld, public将是默认区域
区域也可以用于不同的网络接口, 如: 
要分离内部网络和互联网的接口, 你可以在internal区域上允许DHCP, 但在external区域仅允许HTTP和SSH
未明确设置为特定区域的任何接口将添加到默认区域
external区域仅允许HTTP和SSH
未明确设置为特定区域的任何接口将添加到默认区域
1. 查看默认区域
> firewall-cmd --get-default-zone
2. 修改默认区域
> firewall-cmd --set-default-zone=internal
3. 查看网络接口使用的区域
> firewall-cmd --get-active-zones
4. 获取特定区域的所有配置
> firewall-cmd --zone=public --list-all
5. 获取所有区域的配置
> firewall-cmd --list-all-zones

# 与服务一起使用
firewalld可以根据特定网络服务的预定义规则来允许相关流量
你可以创建自己的自定义系统规则, 并将它们添加到任何区域
默认支持的服务配置文件: /usr/lib/firewalld/services
用户创建的服务文件: /etc/firewalld/services
1. 查看默认的可用服务
> firewall-cmd --get-services
2. 启用或禁用HTTP服务
> firewall-cmd --zone=public --add-service=http --permanent
> firewall-cmd --zone=public --remove-service=http --permanent

# 端口转发
1. 在同一台服务器上将80端口的流量转发到12345端口
> firewall-cmd --zone="public" --add-forward-port=port=80:proto=tcp:toport=12345
2. 将端口转发到另一台服务器
> firewall-cmd --zone=public --add-masquerade  //在需要的区域中激活masquerade
> firewall-cmd --zone="public" --add-forward-port=port=80:proto=tcp:toport=8080:toaddr=123.156.78.9
要删除规则, 用--remove替换--add

# 构建规则集
为web服务器配置基本规则
1. 将eth0的默认区域设置为dmz, dmz(非军事区)只允许ssh和ICMP
> firewall-cmd --set-default-zone=dmz
> firewall-cmd --zone=dmz --add-interface=eth0
2. 添加http和https的永久服务规则到dmz区域
> firewall-cmd --zone=dmz --add-service=http --permanent
> firewall-cmd --zone=dmz --add-service=https --permanent
> firewall-cmd --reload

# 高级配置
服务和端口适用于基本配置, 但对于高级情景可能会限制较多
丰富Rich规则和直接Direct接口允许你为任何端口、协议、地址和操作向任何区域 添加完全自定义的防火墙规则
+ 丰富规则
丰富规则的语法很多, 完整地记录在firewalld.richlanguage(5)手册页中
> man firewalld.richlanguage
使用--add-rich-rule, --list-rich-rules, --remove-rich-rule来管理
1. 允许来自主机192.168.0.14的所有IPv4流量
> firewall-cmd --zone=public --add-rich-rule 'rule family="ipv4" source address=192.168.0.14 accept'
2. 拒绝来自主机192.168.1.10到22端口的IPv4的TCP流量
> firewall-cmd --zone=public --add-rich-rule 'rule family="ipv4" source address="192.168.1.10" port port=22 protocol=tcp reject'
3. 允许来自主机10.1.0.3到80端口的IPv4的TCP流量, 并将流量转发到6532端口
> firewall-cmd --zone=public --add-rich-rule 'rule family=ipv4 source address=10.1.0.3 forward-port port=80 protocol=tcp to-port=6532'
4. 将主机172.31.4.2上80端口的IPv4流量转发到8080端口(需要在区域上激活masquerade)
> firewall-cmd --zone=public --add-rich-rule 'rule family=ipv4 forward-port port=80 protocol=tcp to-port=8080 to-addr=172.31.4.2'
+ iptables的直接接口
对于最高级的使用, 或对于iptables专家, firewalld提供了一个直接Direct接口, 允许你给它传递原始iptables命令
直接接口规则不是持久的, 除非使用--permanent
查看添加到firewalld的所有自定义链或规则
> firewall-cmd --direct --get-all-chains
> firewall-cmd --direct --get-all-rules
