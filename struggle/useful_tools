1. aria2: lightweight multi-protocol multi-source command-line download utility		https://aria2.github.io
The mainline DHT bootstrap nodes: (port: 6881)
 dht.transmissionbt.com
 router.utorrent.com
 router.bittorrent.com
Configuring aria2: ~/.aria2/aria2.conf
 enable-xml-rpc
 follow-torrent=mem
 seed-ratio=2
1) Download from WEB
aria2c http://example.org/mylinux.iso
2) Download from 2 sources
aria2c http://a/f.iso ftp://b/f.iso
3) Download using 2 connections per host
aria2c -x2 http://a/f.iso
4) BitTorrent
aria2c linux-dist.torrent  (already have a torrent file)
aria2c http://example.org/mylinux.torrent  (download the torrent file and start downloading data)
aria2c --follow-torrent=mem http://local/linux-dist.torrent  (the actual torrent file will be stored into a memory only,and discarded when downloading is finished)
5) BitTorrent Magnet URI
aria2c 'magnet:?xt=urn:btin:248D0A1CD08284299DE78D5C1ED359BB46717D8C'
6)Metalink
aria2c http://example.org/mylinux.metalink
7) Download URIs found in text file
aria2c -i uris.txt

2. preview HTML documents from the command line
sudo apt-get install w3m
w3m -dump askubuntu.com | less
w3m -dump index.html | less
w3m -dump -cols 200 file.html  (set the number of columns)

3. redshift
https://github.com/jonls/redshift

4. namebench: find the best DNS servers to use
sudo apt-get install python-tk
wget http://namebench.googlecode.com/files/namebench-1.3.1-source.tgz
tar xvfvz namebench-1.3.1-source.tgz
cd namebench-1.3.1
./namebench.py

  chrome
1. 将下载源加入到系统的源列表
# sudo wget https://repo.fdzh.org/chrome/google-chrome.list
-P /etc/apt/sources.list.d/
2. 导入谷歌软件的公钥
# wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
3. 更新系统的可用更新列表
# sudo apt-get update
4. 安装chrome稳定版
# sudo apt-get install google-chrome-stable
5. 打开
/usr/bin/google-chrome-stable
  开启IPV6
1. # sudo apt-get install miredo
2. # ifconfig 查看teredo的虚拟网卡
3. # ping6 ipv6.google.com
4. # sudo vi /etc/hosts 添加hosts列表
  # sudo /etc/init.d/networking restart
（或# sudo /etc/init.d/dns-clean start或
# sudo apt-get install nscd # sudo /etc/init.d/nscd restart）
5. # sudo vi /etc/default/ufw 将IPV6=no 改成yes
6. # sudo ufw disable
# sudo ufw enable
  aria2c
1. 安装
# sudo apt-get install aria2
2. 配置
# sudo mkdir /etc/aria2
# sudo touch /etc/aria2/aira2.session
# sudo chmod 777 /etc/aria2/aria2.session
# sudo vi /etc/aria2/aria2.conf
3. 启动
# sudo aria2c --conf-path=/etc/aria2/aria2.conf -D (-D 后台运行)
查找并移除陈旧的PPA
1. # sudo apt-get update | grep "Failed"
# sudo add-apt-repository --remove ppa:finalterm/daily
# sudo apt-get update
