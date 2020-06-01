# tcp/ip协议
   
## 帧头帧尾大小

+ 以太网EthernetII
  + 每个以太网帧都有最小64Bytes最大1518Bytes的限制，在范围外的以太网帧都可以视之为错误的数据帧，一般以太网转>    发设备会丢弃这些数据帧
  + 以太网帧
    + 帧头(14Bytes): DMAC, 6Bytes; SMAC, 6Bytes; Type域, 2Bytes
	+ 帧尾(4Bytes): CRC校验, 4Bytes
+ ip数据包
  + ip数据包包头(20Bytes)
+ tcp数据包
  + tcp数据段包头(20Bytes)

## MTU/MSS

+ MTU (Maxitum Transmission Unit, 最大传输单元)
  + MTU=1518-18=1500
+ MSS (Maxitum Segment Size, 最大分段大小)
  + MSS=MTU-20-20=1500-40=1460

## ip分片

+ 网络层IP协议会检查每个从上层协议下来的数据包大小，并根据本机MTU的大小决定是否做分片处理
+ tcp协议是面向连接的协议，非常在意数据包的到达顺序以及传输中是否有错误发生，所以有些tcp应用对分片有要求，不能分片 (DF, DonotFragment)，这样当这个IP数据包在网络传输时，遇到MTU小于IP数据包的情况时，转发设备就会丢弃这个数据包，然后返回一个错误信息给发送者
