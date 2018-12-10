# free, 查询可用内存

free工具用来查看系统可用内存, 所有数据默认单位都是KB

```
1. display memory figures in huamn readable form
free -h

2. make free display results continuously with time gap
free -s 3  //-s, --seconds delay

3. make free to run only a set number of times
free -s 3 -c 5  //-c, --count count

4. Binary Prefix (kibi, mibi, gibi) or Metric Prefix (kilo, mega, giga)
free -m  //mibi, 2^20
free -m --si  //mega, 10^6
```
