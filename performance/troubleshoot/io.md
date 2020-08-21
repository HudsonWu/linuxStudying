# high io wait

```
# top
cpu %iowait

# iostat
iostat -x 2 5

# iotop

# ps
for x in `seq 1 1 10`; do ps -eo state,pid,cmd | grep "^D"; echo "----"; sleep 5; done
cat /proc/16528/io
lsof -p 16528
df /tmp
pvdisplay
```
