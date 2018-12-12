# interfaces(5) file used by ifup(8) and ifdown(8)

auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.168.137.141
    netmask 255.255.255.0
    network 192.168.137.0
    broadcast 192.168.137.255
    gateway 192.168.137.1
    dns-nameservers 192.168.137.1 114.114.114.114
    dns-domain mshome.net
    dns-search mshome.net

# allow-hotplug wlan0
# iface wlan0 inet manual
#     wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
