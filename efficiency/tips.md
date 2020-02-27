# 小技巧

```
# 密码生成器, 生成随机字符串
pwgen -Bsvy1 8
```

## 历史命令

```
^old^new    //替换上一条命令中的字符串后重新执行
^old    //删除上一条命令中的字符串后重新执行

!!    //上一条命令
!:gs/old/new    //替换上一条命令中的字符串后重新执行
!$, !!:$    //上条命令最后一个参数
!^, !!:^    //上条命令第一个参数
!:n    //上条命令第n个参数
!:x-y    //上条命令第x个参数到第y个参数
!:n*    //上条命令从第n个参数到最后
!*    //上条命令所有参数

!foo    //历史命令中以foo开头的命令
!?foo    //历史命令中含有foo的命令
!n    //第n个命令
!-n    //倒数第n个命令

:h    //选取路径开头, 
:t    //选取路径结尾, 
:r    //选取文件名,
:e    //选取扩展名,
如前一条命令为ls /usr/share/fonts/truetype, 
执行cd !!:$:h相当于cd /usr/share/fonts

:p    //打印命令行
:s    //做替换
:g    //全局
```


## Reference

<https://www.ibm.com/developerworks/cn/linux/l-10sysadtips>

