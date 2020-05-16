# date命令

date命令用于显示和设置系统日期和时间，默认使用系统配置的时区显示。

语法：
```
date [OPTIONS]... [+FORMAT]
date [-u|--utc|--universal] [MMDDhhmm[[CC]YY][.ss]]
```

## tricks

```
# 查看系统开机时间
date -d "`cut -f1 -d. /proc/uptime` seconds ago"
```

## 使用示例

```sh
# -u, GMT(Greenwich Mean Time)/UTC(Coordinated Universal Time)
$ date -u
Sat 16 May 2020 04:19:41 AM UTC

# -d, --date, 以date格式显示给定的日期字符串
$ date -d "02/04/2019"
Mon 04 Feb 2019 12:00:00 AM CST
$ date -d "Feb 4 2019"
Mon 04 Feb 2019 12:00:00 AM CST
$ date --date="2 year ago"
Wed 16 May 2018 12:25:11 PM CST
$ date --date="10 sec ago"
Sat 16 May 2020 12:25:29 PM CST
$ date --date="yesterday"
Fri 15 May 2020 12:26:17 PM CST
$ date -d "next tue"
Tue 19 May 2020 12:00:00 AM CST
$ date -d "2 day"
Mon 18 May 2020 12:27:35 PM CST
$ date -d "tomorrow"
Sun 17 May 2020 12:27:29 PM CST

# -s, --set, 设置系统日期和时间
$ date --set="Tue Nov 13 15:23:34 CST 2018"
Tue 13 Nov 2018 03:23:34 PM CST

# -f, --file, 从文件中读取日期字符串并以date格式显示
$ cat >> datefile
Sep 23 2018
Nov 03 2019
$ date -f datefile 
Sun 23 Sep 2018 12:00:00 AM CST
Sun 03 Nov 2019 12:00:00 AM CST

# -r, 显示文件的上一次编辑时间
$ date -r file.txt 
Sat 16 May 2020 11:46:54 AM CST
$ touch file.txt 
$ date -r file.txt 
Sat 16 May 2020 12:36:22 PM CST
```

## 以指定格式显示

语法：
```
date +%[format-option]
```

format-option:
```
%D, 以mm/dd/yy显示日期
%d, 显示day (01-31)
%a, 显示星期名称缩写 (Sun-Sat)
%A, 显示完整的星期名称 (Sunday-Saturday)
%h, %b, 显示月份名称缩写 (Jan-Dec)
%B, 显示完整的月份名称 (January-December)
%m, 显示month (01-12)
%y, 以最后两个数字显示year (00-99)
%Y, 显示four-digit year
%T, 以HH:MM:SS显示时间，24小时格式
%H, 显示hour
%M, 显示minute
%S, 显示seconds
```

示例：
```shell script
$ date "+%D %T"
05/16/20 12:50:12
$ date "+%Y-%m-%d"
2020-05-16
$ date "+%Y/%m/%d"
2020/05/16
$ date "+%A %B %d %T %y"
Saturday May 16 12:51:35 20
```