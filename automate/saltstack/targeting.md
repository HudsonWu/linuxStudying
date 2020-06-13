# targeting

## target types

```
# minion ID
salt 'minion*' disk.usage

# grains
salt -G 'os:Ubuntu' test.ping

# regular expression
salt -E 'minion[0-9]' test.ping

# list
salt -L 'minion1,minion2' test.ping

# multiple target types
salt -C 'G@os:Ubuntu and minion* or S@192.168.50.*' test.ping
```
