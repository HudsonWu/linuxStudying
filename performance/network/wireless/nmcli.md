# nmcli, command-line tool for controlling NetworkManager

## Establish a Wireless Connection

1. Determine the name of the WIFI interface
```console
$ nmcli d
DEVICE    TYPE    STATE     CONNECTION
wlan0     wifi   disconnect     --
...
```
2. Make sure the WIFI radio is on
```
nmcli r wifi on
```
3. List the available WiFi networks
```
nmcli d wifi list
```
4. Connect to the access point
```
nmcli d wifi connect my_wifi password <password>
```
`<password>` is the password for the connection which needs to have 8-63 characters or 64 hexadecimal characters to specify a full 256-bit key

### Connect to a hidden network

A hidden network is a normal wireless network that simply does not broadcast it's SSID unless solicited. This means that its name cannot be searched and must be known from some other source.

1. Issue the following command to create a connection associated with a hidden network `<ssid>`
```
nmcli c add type wifi con-name <name> ifname wlan0 ssid <ssid>
nmcli c modify <name> wifi-sec.key-mgmt wpa-psk wifi-sec.psk <password>
```
2. Establish a connection
```
nmcli c up <name>
```

## nmtui, great interactive ncurses network manager option
