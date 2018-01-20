#!/bin/bash
cat /dev/null > /etc/resolv.conf
while read ns
do
	echo $ns >> /etc/resolv.conf
done < /root/myGithub/linuxStudying/others/logs/dnsChange/dnsByMe.conf
# /etc/init.d/networking restart
systemctl restart systemd-networkd
systemctl restart systemd-resolved
