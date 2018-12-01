# 字符和时区

## 字符

1. 查看字符集
```
> echo $LANG
> env | grep LANG
> export | grep LANG
> locale -a  //查看本地字符集
> locale -m  //查看所有支持的字符集
```

2. set、env和export
```
set  显示当前shell的变量，包括当前用户的变量
env  显示当前用户的变量
export  显示当前导出成用户变量的shell变量
set用来显示本地变量  env用来显示环境变量  export用来显示和设置环境变量
```

3. 修改字符集
```
//直接设置变量
LANG="zh_CN.UTF-8"
LC_ALL="zh_CN.UTF-8"
只在当前shell中生效

//修改文件方式，/etc/sysconfig/i18n (CentOS)
LANG="zh_CN.UTF-8"	//当前系统的语言环境变量
SUPPORTED="zh_CN.UTF-8:zh_CN.GB18030"	//系统预置了哪些语言支持
SYSFONT="latarcyrheb-sun16"	//定义控制台终端字体
修改完后，执行命令source /etc/sysconfig/i18n

//locale-gen
> locale-gen zh_CN
> locale-gen zh_CN.UTF-8
> update-locale  （debian）
> dpkg-reconfigure locales  //重新配置

//安装几个包解决kali出现字符串重叠问题
> apt-get install ttf-wqy-microhei ttf-wqy-zenhei xfonts-wqy
```

## 时区
<pre>
1. 显示时区
> date -R
> date +%z
+0800 东八区
2. 修改时区
> cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
时区的信息存在/usr/share/zoneinfo目录下, 本机的时区信息存在/etc/localtime文件
OR
> tzselect  //互动式命令
</pre>
