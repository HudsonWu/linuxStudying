# dd, 读取, 转换并输出数据

dd命令用于复制文件并对原文件的内容进行转换和格式化处理 <br/>
可从标准输入或文件中读取数据, 根据指定的格式来转换数据, 再输出到文件、设备或标准输出 <br/>

## 实例

1. 在linux下制作启动盘
```
dd if=boot.img of=/dev/fd0 bs=1440k
```

2. 将`testfile`文件中的所有英文字母转换为大写, 然后转成`testfile_1`文件
```
dd if=testfile of=testfile_1 conv=ucase
```

3. 有标准输入设备读入字符串, 将字符串转换成大写后, 输出到标准输出设备
```
dd conv=ucase
```
按组合键Ctrl+D退出, 转换成大写结果

4. 创建一个50M的文件
```
dd if=/dev/zero of=test.log bs=1M count=50
```
/dev/zero是一个字符设备, 会不断返回0值字节(\0) <br/>
bs代表字节为单位的块大小, count代表被复制的块数 <br/>

## 参数说明

+ if=文件名, 输入文件名, 默认为标准输入
+ of=文件名, 输出文件名, 默认为标准输出
+ ibs=bytes, 一次读入bytes个字节, 即指定一个读入块, 大小为bytes个字节
+ obs=bytes, 一次输出bytes个字节, 即指定一个输出块, 大小为bytes个字节
+ bs=bytes, 同时设置读入/输出的块大小为bytes个字节
+ cbs=bytes, 一次转换bytes个字节, 即指定转换缓冲区大小
+ skip=blocks, 从输入文件开头跳过blocks个块后再开始复制
+ seek=blocks, 从输出文件开头跳过blocks个块后再开始复制
+ count=blocks, 仅拷贝blocks个块, 块大小等于ibs指定的字节数
+ conv=<关键字>
    + conversion, 用指定的参数转换文件
    + ascii, 转换ebcdic为ascii
    + ebcdic, 转换ascii为ebcdic
    + ibm, 转换ascii为alternate ebcdic
    + block, 把每一行转换为长度为cbs, 不足部分用空格填充
    + unblock, 使每一行的长度都为cbs, 不足部分用空格填充
    + lcase, 把大写字符转换为小写字符
    + ucase, 把小写字符转换为大写字符
    + swab, 交换输入的每对字节
    + noerror, 出错时不停止
    + notrunc, 不截短输出文件
    + sync, 将每个输入块填充到ibs个字节, 不足部分用空(NUL)字符补齐
+ --help, 显示帮助信息
+ --version, 显示版本信息

块大小可以使用的计量单位表: <br/>
<table>
<thead><tr>
    <th align="center">单元大小</th>
    <th aligh="center">代码</th>
</tr></thead>
<tbody>
<tr>
    <td align="center">字节(1B)</td>
    <td align="center">c</td>
</tr>
<tr>
    <td align="center">字节(2B)</td>
    <td align="center">w</td>
</tr>
<tr>
    <td align="center">块(512B)</td>
    <td align="center">b</td>
</tr>
<tr>
    <td align="center">千字节(1024B)</td>
    <td align="center">K</td>
</tr>
<tr>
    <td align="center">兆字节(1024KB)</td>
    <td align="center">M</td>
</tr>
<tr>
    <td align="center">吉字节(1024MB)</td>
    <td align="center">G</td>
</tr>
</tbody>
</table>
