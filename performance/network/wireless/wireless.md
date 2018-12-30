# 连接到wireless network

## 使用到的工具 

+ `ifconfig`: Enable your wireless device
+ `iwlist`: List the available wireless access points
+ `iwconfig`: Configure your wireless access points
+ `dhclient`: Get your IP Address via dhcp
+ `wpa_supplicant`: For use with WPA authentication

## 连接到非WPA认证的无线网络(non-WPA authentication-based wireless networks) 

1. 启用无线网卡
```
iwconfig  //检查是哪一个接口支持无线连接

//启动无线接口
ifconfig wlan0 up
//or
ip link set wlan0 up
```

2. 扫描可用的无线接入点
```
iwlist wlan0 scan
//or
iw dev wlan0 scan
```

3. 连接到指定网络
```
iwconfig wlan0 essid Network_name key wireless_key
//or
iw dev wlan0 connect [网络SSID]  //没有加密
iw dev wlan0 connect [网络SSID] key 0:[WEP密钥]  //WEP加密
```
iwconfig命令指定的`wireless_key`默认是十六进制(HEX), 如果要使用ascii, 在前面加上s:, 如下
```
iwconfig wlan0 essid Network_name key s:wireless_key
```

4. 通过dhcp分配一个ip地址
```
dhclient wlan0
```

## 连接到WPA加密网络(WPA-based networks) 

1. 使用`wpa_passphrase`命令生成配置文件
```
wpa_passphrase "ssid" "password" > /etc/wpa_supplicant/example.conf
```

2. 使用`wpa_supplicant`命令
```
wpa_supplicant -B -i INTERFACE -c /etc/wpa_supplicant/example.conf
```
INTERFACE就是无线网卡名称, 一般为wlan0

3. 使用iwconfig命令查看无线网卡情况
```
iwconfig INTERFACE
```

4. 使用dhclient命令分配ip
```
dhclient INTERFACE
```

5. 写入/etc/network/interfaces文件
```
auto INTERFACE
iface INTERFACE inet dhcp
pre-up wpa_supplicant -B -i INTERFACE -c /etc/wpa_supplicant/example.conf
post-down killall -q wpa_supplicant
```

<https://www.linux.com/learn/how-configure-wireless-any-linux-desktop>
