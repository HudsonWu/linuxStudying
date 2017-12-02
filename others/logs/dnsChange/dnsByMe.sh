#!/bin/bash
cat /dev/null > /etc/resolv.conf
while read ns
do
	echo $ns >> /etc/resolv.conf
done < dnsByMe.conf
/etc/init.d/networking restart
