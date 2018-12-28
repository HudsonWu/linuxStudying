# dmidecode, 查看硬件信息

dmidecode命令可以让你获取有关硬件方面的信息, 作用是将DMI数据库中的信息解码, 以可读的文本方式显示(由于DMI信息可以人为修改, 因此里面的信息不一定是系统准确的信息), dmidecode遵循SMBIOS/DMI标准, 其输出的信息包括BIOS、系统、主板、处理器、内存、缓存等, 既可以得到当前的配置, 也可以得到系统支持的最大配置

+ DMI, Desktop Management Interface
    + DMI就是帮助收集电脑系统信息的管理系统, DMI信息的收集必须在严格遵照SMBIOS规范的前提下进行
+ SMBIOS, System Management BIOS
    + SMBIOS, 是主板或系统制造者以标准格式显示产品管理信息所需遵循的统一规范

SMBIOS和DMI是由行业指导机构Desktop Management Task Force(DMTF)起草的开放性技术标准, 其中DMI设计适用于任何平台和操作系统

DMI充当了管理工具和系统层之间接口的角色, 它建立了标准的可管理系统, 更加方便了电脑厂商和用户对系统的了解. DMI的主要组成部分是Management Information Format(MIF)数据库, 这个数据库包括了所有有关电脑系统和配件的信息. 通过DMI, 用户可以获取序列号, 电脑厂商, 串口信息以及其他系统配件信息

## 语法

dmidecode [options]

```
-d, (default:/dev/mem)从设备文件读取信息, 输出内容与不加参数标准输出相同
-s, string, 只显示指定DMI字符串的信息
-t, type, 只显示指定条目的信息
-u, 显示未解码的原始条目内容
-q, 只显示必要的信息
--dump-bin file, 将DMI数据存储到一个二进制文件中
--from-dump FILE, 从一个二进制文件读取DMI数据
-V, 显示版本信息
-h, 显示帮助信息
```

## dmidecode参数string及type列表

1. Valid string keywords
```
bios-vendor
bios-version
bios-release-date
system-manufacturer
system-product-name
system-version
system-serial-number
system-uuid
baseboard-manufacturer
baseboard-product-name
baseboard-version
baseboard-serial-number
baseboard-asset-tag
chassis-manufacturer
chassis-type
chassis-version
chassis-serial-number
chassis-asset-tag
processor-family
processor-manufacturer
processor-version
processor-frequency
```

2. Valid type keywords
```
bios
system
baseboard
chassis
processor
memory
Cache
connector
slot
```

3. type全部编码列表
```
BIOS
System
Base Board
Chassis
Processor
Memory Controller
Memory Module
Cache
Port Connector
System Slots
On Board Devices
OEM Strings
System Configuration Options
BIOS Language
Group Associations
System Event Log
Physical Memory Array
Memory Device
32-bit Memory Error
Memory Array Mapped Address
Memory Device Mapped Address
Built-in Pointing Device
Portable Battery
System Reset
Hardware Security
System Power Controls
Voltage Probe
Cooling Device
Temperature Probe
Electrical Current Probe
Out-of-band Remote Access
Boot Integrity Services
System Boot
64-bit Memory Error
Management Device
Management Device Component
Management Device Threshold Data
Memory Channel
IPMI Device
Power Supply
Additional Information
Onboard Device
```

## 实例

```
dmidecode | grep 'Product Name'  //服务器型号
dmidecode | grep 'Serial Number'  //主板序列号
dmidecode -s system-serial-number  //系统序列号
dmidecode -t memory  //内存信息
dmidecode -t processor  //处理器信息
dmidecode -t 0,4  //显示多种类型的信息
dmidecode -t 11  //OEM信息

//查看内存槽数、那个槽位插了内存，大小是多少
dmidecode|grep -P -A5 "Memory\s+Device"|grep Size|grep -v Range

//查看最大支持内存数
dmidecode|grep -P 'Maximum\s+Capacity'

//查看槽位上内存的速率，没插就是unknown
dmidecode|grep -A16 "Memory Device"|grep 'Speed'
```
不带选项执行dmidecode命令通常会输出所有的硬件信息, -t选项可以按指定类型输出相关信息

## References

+ [dmidecode命令](http://man.linuxde.net/dmidecode)
+ [linux下dmidecode命令获取硬件信息](http://www.ttlsa.com/linux/the-linux-dmidecode-command-to-get-the-hardware-information)
