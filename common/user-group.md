1. 查看所有用户和用户组

```
cat /etc/passwd
cat /etc/group
id user1  查看用户user1的UID和GID
finger user1  查看用户user1的主目录、启动shell、用户名、地址、电话等信息
usermod -a -G groupA user1  将user1添加到用户组groupA中
```

2. 新建用户

```
adduser hudson  会在home目录下添加一个帐号
useradd hudson  仅仅是添加用户，不会在home目录添加帐号
useradd 选项 用户名
-c  指定一段注释性描述（comment）
-d  指定用户主目录，若目录不存在，使用-m选项，可以创建主目录
-g  指定用户所属的用户组
-G  指定用户所属的附加组
-s  指定用户的登录shell
-u  指定用户的用户号（uid）
useradd user1 -g 1002 -u 1003 -m
useradd -m -U -d /opt/tomcat -s /bin/false tomcat
passwd 选项 用户名
-l  锁定口令，即禁用账号
-u  口令解锁
-d  使账号无口令
-f  强迫用户下次登录时修改口令
usermod -a -G adm user1
usermod -a -G sudo user1   为user1添加sudo权限
userdel user2  删除用户user2
userdel -r user2  删除用户user2，同时删除工作目录
```

3. 增加用户组

```
groupadd 选项 用户组
-g  为用户组指定组标识号（GID）
-o  与-g选项同时使用，用户组的GID可以与系统已有用户组的GID相同
groupadd -g 888 users  创建一个组users，其GID为888
gpasswd（只有root和组管理员能够改变组成员）
gpasswd -a user1 users  把user1加入users组
gpasswd -d user1 users  把user1退出users组
gpasswd --delete user1 users 把user1退出users组
groupmod 修改组
groupmod -n user users  修改组名user为users
groupdel  删除组
groupdel users  删除组users
```

4. 相关系统文件

```
/etc/passwd  用户管理工作最重要的一个文件，记录了每个用户的一些基本属性
用户名:口令:用户标识号:组标识号:注释性描述:主目录:登录shell
现在许多linux系统使用了shadow技术，把真正的加密口令存放在/etc/shadow文件中，而在/etc/passwd文件的口令字段中之存放一个特殊的字符
登录shell：用户登录后，要启动一个进程，负责将用户的操作传给内核，这个进程是用户登录到系统后运行的命令解释器或某个特定的程序，即shell
shell是用户与linux系统之间的接口，linux的shell有很多种，常见的有sh(Bourne Shell),csh(C Shell),ksh(Korn Shell),bash(Bourne Again Shell)等
系统管理员可以根据系统情况和用户习惯为用户指定某个Shell，若不指定，系统使用sh为默认的登录shell
```

5. visudo

```
user1 ALL=(ALL) ALL
user1 ALL = NOPASSWD: /usr/bin/docker, /usr/local/bin/docker-compose
```
