#!/bin/bash

cat /dev/null > /etc/resolv.conf

if [ $# -eq 0 ]
	then 
		echo "No arguments supplied, dns will be the default"
		echo "nameserver 8.8.4.4" > /etc/resolv.conf
		echo "nameserver 114.114.114.114" >> /etc/resolv.conf
else
	if [ -z "$2" ]
		then
			echo "argument 2 not supplied, the second nameserver will be the default"
			echo "nameserver $1" > /etc/resolv.conf
			echo "nameserver 8.8.4.4" >> /etc/resolv.conf
	else
		echo "nameserver $1" > /etc/resolv.conf
		echo "nameserver $2" >> /etc/resolv.conf
	fi
fi

/etc/init.d/networking restart

echo "Success, Please checkout the nameservers"
cat /etc/resolv.conf
