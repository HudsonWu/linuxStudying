# Show list of network cards

1. lspci

```console
# lspci | egrep -i --color 'network|ethernet'
09:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5761e Gigabit Ethernet PCIe (rev 10)
0c:00.0 Network controller: Intel Corporation Ultimate N WiFi Link 5300
```

2. lshw

```
lshw -class network
```

3. ip

```
ip link show
ip a
```

4. /proc/net/dev

The dev pseudo-file contains network device status information. This gives the number of received and sent packets, the number of errors and collisions and other basic statistics.
```
cat /proc/net/dev
```
