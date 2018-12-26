# 一些小技巧和有用的工具

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

## lrzsz, xshell上传下载工具包

安装的工具包名为`lrzsz`, 包括rz命令和sz命令 (receive和send)

## autojump 

命令行跳转工具, 帮助快速从目录访问历史中的各个目录中迅速跳转 

## thefuck 

命令纠错 

## tig 

命令行下查看git历史提交记录的工具 

## git summary 

大致了解每个人对这个项目提交的commit数量和贡献度

## [ydict](https://github.com/TimothyYe/ydict) 

命令行方式的有道词典

## [er](https://github.com/TimothyYe/exchangerate)  

命令行下查询和换算货币汇率 

