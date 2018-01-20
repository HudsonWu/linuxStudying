1. /etc/systemd/network/50-static.network
[Match]
Name=eth0
[Network]
Address=192.168.56.110/24
# Gateway=192.168.0.1
# DNS=8.8.4.4
2. /etc/systemd/network/80-dhcp.network
[Match]
Name=eth1
[Network]
DHCP=yes
3. systemctl enable systemd-networkd
   systemctl enable systemd-resolved
   # ln -sf /run/system/resolve/resolv.conf /etc/resolv.conf
