auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    metric 1
    address 192.168.137.191
    netmask 255.255.255.0
    broadcast 192.168.137.255
    gateway 192.168.137.1

# auto wlan0  
iface wlan0 inet dhcp
    metric 0
# wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

allow-hotplug wlan0 eth0

pre-up wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf  
post-down killall -q wpa_supplicant 
