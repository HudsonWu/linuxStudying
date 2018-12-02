#iptables

```
iptables -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
```

## 基础语法
```
1. 规则的观察与清除
iptables [-t tables] [-L] [-nv]

-t 后面接tables，例如nat或filter，默认filter
-L 列出目前的table的规则
-n 列出更多的信息，包括通过改规则的封包总位数、相关的网络接口等

iptables [-t tables] [-FXZ]

-F 清除所有的已订定的规则
-X 杀掉所有使用者“自定义”的chain(应该是tables)
-Z 将所有的chain的计数与流量统计都归零

2. 封包的基础比对：IP、网域及接口装置

iptables [-AI 链名] [-io 网络接口] [-p 协议] [-s 来源IP/网域] -j [ACCEPT|DROP|REJECT|LOG]

-AI 链名 针对某的链进行规则的“插入”和“累加”
  -A 新增加一条规则，该规则增加在原有规则的最后面
  -I 插入一条规则，如果没有指定此规则的顺序，默认是插入变成第一条规则
  链 有INPUT、OUTPUT、FORWARD等
-io 网络接口 设定封包进出口的接口规范
  -i 封包所进入的那个网络接口，例如eth0、lo等接口，需与INPUT链配合
  -o 封包所传出的那个网络接口，需与OUTPUT链配合
-p 协定 设定次规则适用于哪种封包格式
  主要的封包格式有：tcp udp icmp all
-s 来源IP/网域 设定此规则之封包的来源项目，可单纯指定的IP或包括网域，例如
  IP：192.168.8.100
  网域：192.168.0.0/24, 192.168.0.0/255.255.255.0均可
  若规范为 不许 时，则加上 ！ 如：
  -s ! 192.168.100.0/24
-d 目标IP/网域，同-s，只是这里指定的是目标的IP或网域
-j 后面接动作，主要的动作有接受(ACCEPT)、丢弃(DROP)、拒绝(REJECT)及记录(LOG)

3. TCP、UDP的规则比对：针对端口设定

iptables [-AI 链] [-io 网络接口] [-p tcp,udp] [-s 来源IP/网域] [--sport 埠口范围] [-d 目标IP/网域] [--dport 埠口范围]

--sport 限制来源的端口号码，端口号码可以是连续的，如1024:65535
--dport 限制目标的端口号码

4. iptabes 外挂模块：mac 和 state

iptables -A INPUT [-m state] [--state 状态]
-m 一些iptables的外挂模块
  state 状态模块
  mac 网络卡硬件地址(hardware address)
--state 一些封包的状态
  INVALID 无效的封包，例如数据破损的封包状态
  ESTABLISHED 已经联机成功的联机状态
  NEW 想要新建立联机的封包状态
  RELATED 这个最常用，表示这个封包与我们主机发送出去的封包有关

5. ICMP 封包规则的比对：针对是否相应ping来设计

iptables -A INPUT [-p icmp] [--icmp-type 类型] -j ACCEPT
--icmp-type 后面必须要接ICMP的封包类型，也可以使用代号
  如 8 代表 echo request
```

## 配置iptables白名单机制
```
1. 清除所有规则（慎用）
iptables -F
iptables -X
iptables -Z
2. 查看iptable和行号
iptables -nL --line-number
3. 保存当前防火墙配置
service iptables save
4. 手动编辑防火墙策略
vi /etc/sysconfig/iptables
5. 重启生效
service iptables restart
6. 复查结果
iptables -nL --line-number
```
