https://shapeshed.com/linux-wifi/
wpa_supplicant, 无线网络管理和配置工具
实现方式: 开启wpa_supplicant守护进程, 使用wpa_cli程序连接这个进程并配置网卡
# 使用步骤 #
1. 找到需要配置的无线网卡
> ip a
2. 开启守护进程
  .conf配置文件
> ctrl_interface=DIR=/run/wpa_supplicant GROUP=root
> update_config=1
文件可以取任意的名字, 存放在/etc/wpa_supplicant目录下
GROUP=wheel, 允许在wheel组下的用户可以连接到守护进程, 管理无线网络
  文件创建后执行下面的命令开启守护进程
> wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/example.conf
-B, 在后台运行;  -i, 指定网卡  -c, 指定配置文件
3. 使用wpa_cli连接到守护进程
query current status, change configuration, trigger events, and request interactive user input.
wpa_cli启动后是一个交互模式
4. wpa_cli交互命令行
  扫描网络
> scan
OK
<3>CTRL-EVENT-SCAN-STARTED
<3>CTRL-EVENT-SCAN-RESULTS
<3>WPS-AP-AVAILABLE
<3>CTRL-EVENT-NETWORK-NOT-FOUND
  查看扫描结果
> scan_results
bssid / frequency / signal level / flags / ssid 
7c:4c:a5:68:25:69 2412 7 [WPA2-PSK-CCMP][WPS][ESS] SKY1DA97
...
flags可以查看网络的安全模型
  列出已配置网络
> list_networks
  添加并连接到网络
> add_network
0
> set_network 0 ssid "MYNETWORK"
> set_network 0 psk "secret”
> enable_network 0
  保存配置到文件
> save config
