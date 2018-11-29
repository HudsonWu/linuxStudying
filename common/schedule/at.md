# at

at命令用于在指定时间执行命令

语法: at <选项> <参数>

## 选项
-f, 指定包含具体指令的任务文件
-q, 指定新任务的队列名称
-l, 显示待执行任务的列表(atq)
-d, 删除指定的待执行任务(atrm)
-m, 任务执行完成后向用户发送e-mail
-c, 显示设置的任务内容

## 参数
日期时间, 指定任务执行的日期时间

### 绝对计时法
1. hh:mm, (小时:分钟)式的时间指定
2. midnight(深夜), noon(中午), teatime(饮茶时间, 一般下午4点)
3. 12小时计时制, 时间后加上AM或PM
4. 日期指定: MMDD[CC]YY, MM/DD/[CC]YY,DD.MM.[CC]YY,[CC]YY-MM-DD

### 相对计时法
now + count time-units
time-units, 时间单位(minutes, hours, days, weeks)

## 使用
> at 5pm+3 days  //三天后的下午5点
> at 17:00 tomorrow  //明天17:00
> echo "sh backup.sh" | at 9:00 AM
> echo "hello" > /tmp/hello.txt | at 11:46
> echo -f /home/john/test.sh | at 11:55
> at 10:00 AM Sun  //星期天上午10点
> at 10:00 AM July 25
> at 10:00 AM 6/22/2015
> at 10:00 AM 6.22.2015
> at 10:00 AM next month
> at now + 1 hour
> at now + 30 minutes
> at now + 1 year
> at midnight
> at now + 2 weeks
