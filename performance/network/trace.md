# trace networking activity

```
# netstat
netstat -np --inet | grep "thunderbird"
watch 'netstat -np --inet | grep "thunderbird"'

# strace
strace -f -e trace=network <your command> 2>&1 | grep sin_addr
strace -f -e trace=network -p <PID> 2>&1 | grep sin_addr

# sysdig

```
