# snmp

Simple Network Management Protocol, 简单网络管理协议, 是一个标准的用于管理基于IP网络上设备的协议. 它属于TCP/IP协议中的应用层协议

工作方式: 管理员需要从设备处获取数据, 所以SNMP提供了“读”操作; 管理员需要向设备执行设置操作, 所以SNMP提供了“写”操作; 设备需要在重要状况改变的时候, 向管理员通报事件的发生, 所以SNMP提供了“Trap”操作

基本思想: 为不同种类的设备、不同厂家生产的设备、不同型号的设备定义一个统一的接口和协议, 使得管理员可以使用统一的外观面对这些需要管理的网络设备. 通过网络, 管理员可以管理位于不同物理空间的设备, 从而大大提高网络管理的效率

结构概述: SNMP基于TCP/IP协议工作, 对网络中支持SNMP协议的设备进行管理

There are multiple versions of the SNMP protocol, and many networked hardware devices implement some form of SNMP access. The most widely used version is SNMPv1, but it is in many ways insecure. Its popularity largely stems from its ubiquity and long time in the wild. Unless you have a strong reason not to, we recommend you use SNMPv3, which provides more advanced security features.

## SNMP支持的网管操作

+ Get: 读取网络设备的状态信息

+ Set: 远程配置设备参数

+ Trap: 及时获取设备的重要信息

## SNMP的实现结构

在具体实现上, SNMP为管理员提供了一个网管平台(NMS), 又称为管理站, 负责网管命令的发出、数据存储及数据分析. 被监管的设备上运行一个SNMP代理(Agent), 代理实现设备与管理站的SNMP通信

管理站与代理端通过MIB进行接口统一, MIB定义了设备中被管理对象, 管理站和代理都实现了相应的MIB对象, 使得双方可以识别对方的数据, 实现通信. 管理站向代理申请MIB中定义的数据, 代理识别后, 将管理设备提供的相关状态或参数等数据转换为MIB定义的格式, 应答给管理站, 完成一次管理操作

已有的设备, 只要新加一个SNMP模块就可以实现网络支持, 旧的带扩展槽的设备, 只要插入SNMP模块插卡即可支持网络管理. 网络上的许多设备, 路由器、交换机等都可以通过添加一个SNMP网管模块而增加网管功能. 服务器可以通过运行一个网管进程实现, 其他服务级的产品也可以通过网管模块实现网络管理, 如Oracle、WebLogic都有SNMP进程, 运行后就可以通过管理站对这些系统级服务进行管理

## SNMP和UDP

SNMP管理站和SNMP代理之间是松散耦合, 它们之间的通信是通过UDP协议完成的. 一般情况下, SNMP管理站通过UDP协议向SNMP代理发送各种命令, 当SNMP代理收到命令后, 返回SNMP管理站需要的参数, 但是当SNMP代理检测到网络元素异常的时候, 也可以主动向SNMP管理站发送消息, 通知当前异常状况

SNMP采用UDP 161端口接收和发送请求, 162端口接收Trap, 执行SNMP的设备缺省都必须采用这些端口

## SNMP中三种角色

根据管理者和被管理的设备在网络操作中的不同职责, SNMP定义了三种角色: 

网络管理系统(NMS, 管理站): 是系统的控制台, 向管理员提供界面以获取设备的配置、信息、状态、操作等信息. 管理站与Agent进行通信, 执行相应的Set和Get操作, 并接受代理发过来的警报(Trap)

代理(Agent): 负责管理站和设备SNMP操作的传递, 介于管理站和设备之间, 与管理站通信并响应管理站的请求. 从设备获取相应的数据; 对设备进行相应的设置, 来响应管理站的请求; 根据设备的状态使用MIB中定义的Trap向管理站发送报告

代理服务器(Proxy): 一种特殊的代理, 在不能直接使用SNMP协议的地方, 如异种网络、不同版本的SNMP代理等情况, 为设备代理SNMP协议的实现, Proxy为异种网络或不同版本代理做了相应SNMP数据请求的转换工作

## SNMP发展

SNMP共有v1,v2,v3这三个版本: 

v1和v2都具有基本的读、写MIB功能

v2增加了警报、批量数据获取、管理站和管理站通信能力

v3在v2的基础上增加了USM, 使用加密的数据和用户验证技术, 提高了安全性

RMON是SNMP的一个重要扩展, 为SNMP增加了子网流量、统计、分析能力. 现有两个版本: Rmon和Rmon2, Rmon提供了OSI七层网络结构中网络层和数据链路层监视能力; Rmon2提供了OSI七层网络结构中网络层之上各层的监视能力


## 技术术语

宏: 一些命令组织在一起, 作为一个单独命令完成特定任务

MIB: Management Information Base, 管理信息库, 定义代理进程中所有可被查询和修改的参数, 是一个具有分层特性的信息的集合

PDU: Ptotocol Data Unit, 协议数据单元, 它是网络中传送的数据包, 每一种SNMP操作, 物理上都对应一个PDU

ASN.1: Abstract Syntax Notation One, 抽象语法定义, 用于定义语法的正式语言, 在SNMP中定义SNMP的协议数据单元PDU和管理对象MIB的格式; SNMP只使用了ASN.1中的一部分, 而且使用ASN.1的语言特性定义了一些自定义类型和类型宏, 这些组成了SMI

SMI: Structure of Management Information, 管理信息结构, SMI定义了SNMP中使用到的ASN.1类型、语法, 并定义了SNMP中使用到的类型、宏、符号等; SMI用于后续协议的描述和MIB的定义, 每个版本的SNMP都可能定义自己的SMI

NMS: Network Management System, 网络管理系统, 又名网络管理站, 它是SNMP的总控机, 提供统一的用户界面访问支持SNMP的设备, 一般提供UI界面, 并有统计、分析等功能, 是网管系统的总控制台, NMS是网络管理操作的发起者

Agent: 是SNMP的访问代理, 为设备提供SNMP, 负责设备与NMS通信

Proxy: 代理服务器, 对实现不同协议的设备进行协议转换, 使非IP协议的设备也能被管理

Trap: 是由设备主动发起的报警数据, 用于提示重要的状态改变

BER: Basic Encoding Rule, 基本编码规格, 描述如何将ASN.1类型的值编码为字符串的方法, 它是ASN.1标准的一部分, BER编码将数据分成TLV三部分: T(Tag), 类型标识; L(Length), 标识类型的长度; V(Value), 标识数据内容. 按照TLV的顺序对数据进行编码, 生成字节流. SNMP使用BER将SNMP的操作请求和应答编码后进行传输, 并用于接受端进行解码

```
ASN.1、BER、SMI、MIB、PDU的关系
- - - - - - - - - - - - - - - - - - -
|    ASN.1                          |
|                                   |
|  - - - - - - - - - - - - - - -    |
|  |  编码规则      - - - -    |    |
|  |                | BER |    |    |   ---> PDU传输
|  |                - - - -    |    |       
|  - - - - - - - - - - - - - - -    |
|  - - - - - - - - - - - - - - -    |             -- PDU
|  |    语法符号               |    |   ---> SMI |-- MIB
|  - - - - - - - - - - - - - - -    |             -- MIB    
- - - - - - - - - - - - - - - - - - -
```

## References

+ [monitoring-and-managing-your-network-with-snmp](https://www.digitalocean.com/community/tutorial_series/monitoring-and-managing-your-network-with-snmp)
+ [浅谈Linux系统中的SNMP Trap](https://www.ibm.com/developerworks/cn/linux/l-cn-snmp/index.html)
