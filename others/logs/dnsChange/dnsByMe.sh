#!/bin/bash
cat /dev/null > /etc/resolv.conf
while read ns
do
	echo $ns >> /etc/resolv.conf
done < /home/hudson/myGithub/linuxStudying/others/logs/dnsChange/dnsByMe.conf
/etc/init.d/networking restart
