# rsync, remote sync

rsync命令是一个远程数据同步工具, 
rsync使用所谓的"rsync算法"来使本地和远程两个主机之间的文件达到同步, 
这个算法只传送两个文件的不同部分, 而不是每次都整份传送, 因此速度相当快

## 语法

```
# 拷贝本地文件
rsync [OPTION]... SRC DEST
rsync -a /data /backup

# 使用一个远程shell程序将本地机器的内容拷贝到远程机器
rsync [OPTION]... SRC [USER@]HOST:DEST
rsync -avz *.c foo:src

# 使用一个远程shell程序将远程机器的内容拷贝到本地
rsync [OPTION]... [USER@]HOST:SRC DEST
rsync -avz foo:src/bar /data

# 从本地机器拷贝文件到远程rsync服务器
rsync [OPTION]... SRC [USER@]HOST::DEST
rsync -av /databack root@192.168.19.22::www

# 从远程rsync服务器中拷贝文件到本地
rsync [OPTION]... [USER@]HOST::SRC DEST
rsync -av root@192.168.19.22::www /databack

# 列远程机的文件列表
rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]
rsync -v rsync://192.168.19.22/www
```

## 选项

```
-v, --verbose  详细模式输出
-q, --quiet  精简输出模式
-c, --checksum  打开校验开关, 强制对文件传输进行校验
-a, --archive  归档模式, 表示以递归方式传输文件, 并保持所有文件属性, 等于-rlptgoD
-r, --recursive  对子目录以递归模式处理
-R, --relative  使用相对路径信息
-b, --backup  创建备份, 目的已经存在同样文件名时, 将老文件重命名为~filename, 
              可以使用--suffix选项来指定不同的备份文件前缀
--backup-dir  将备份文件存放在该目录下
--suffix=SUFFIX  定义备份文件前缀
-u, --update  仅仅进行更新, 跳过所有已存在于DST, 并且文件时间晚于要备份的文件, 不覆盖更新的文件
-l, --links  保留软链接
-L, --copy-links  对待常规文件一样处理软链接
--copy-unsafe-links  仅仅拷贝指向SRC路径目录树以外的链接
--safe-links  忽略指向SRC路径目录树以外的链接
-H, --hard-links  保留硬链接
-p, --perms  保持文件权限
-o, --owner  保持文件属主信息
-g, --group  保持文件属组信息
-D, --devices  保持设备文件信息
-t, --times  保持文件时间信息
-z, --compress  对备份的文件在传输时进行压缩处理
-S, --sparse  对稀疏文件进行特殊处理以节省DST空间
-n, --dry-run  显示哪些文件将被传输
-w, --whole-file  拷贝文件, 不进行增量检测
-x, --one-file-system  不要跨越文件系统边界
-B, --block-size=SIZE  检验算法使用的块尺寸, 默认700字节
-e, --rsh=command  指定使用rsh, ssh方式进行数据同步
--rsync-path=PATH  指定远程服务器上的rsync命令所在路径信息
-C, --cvs-exclude  使用和CVS一样的方法自动忽略文件, 用来排除那些不希望传输的文件
--existing  仅仅更新那些已经存在于DST的文件
--delete  删除那些DST中SRC没有的文件
--delete-excluded  同样删除接收端那些被该选项指定排除的文件
--delete-after  传输结束后再删除
--ignore-errors  出现IO错误也进行删除
--max-delete=NUM  最多删除NUM个文件
-P, --partial  保留那些因故没有完全传输的文件
--force  强制删除目录, 即使不为空
--numeric-ids  不将数字的用户和组id匹配为用户名和组名
--timeout=time  超时时间, 单位为秒
-I, --ignore-times  不跳过那些有同样的时间和长度的文件
--size-only  决定是否备份文件时, 仅查看文件大小而不考虑文件时间
--modify-window=NUM  决定文件是否时间相同时使用的时间戳窗口, 默认为0
-T, --temp-dir=DIR  在DIR中创建临时文件
--compare-dest=DIR  同样比较DIR中的文件来决定是否需要备份
--progress  显示备份过程
--exclude=PATTERN  指定排除不需要传输的文件模式
--include=PATTERN  指定需要传输的文件模式
--exclude-from=FILE  排除FILE中指定模式的文件
--include-from=FILE  不排除FILE指定模式匹配的文件
--address  绑定到特定的地址
--config=FILE  指定其他的配置文件, 不使用默认的rsyncd.conf
--port=PORT  指定其他的rsync服务端口
--blocking-io  对远程shell使用阻塞IO
-stats  给出某些文件的传输状态
--log-format=FORMAT  指定日志文件格式
--password-file=FILE  从FILE中得到密码
--bwlimit=KBPS  限制I/O带宽, KBytes per second
```

## 实例

```
# 拷贝文件
rsync -zvh backup.tar /tmp/backups/

# 拷贝目录
rsync -avzh /root/rpmpkgs /tmp/backups/

# ssh方式
rsync -vzrtopg --progress -e ssh --delete work@172.16.78.22:/www/* /databack/experiment/rsync

# 后台服务方式
rsync -avz --progress --delete work@172.16.78.22::www /databack/experiment/rsync
rsync -avz --progress /databack/experiment/rsync/ work@172.16.78.22::www
```

## rsyncd

### 服务端

/etc/rsyncd.conf
```
uid = nobody
gid = nobody
use chroot = no
max connections = 10
pid file = /var/run/rsyncd.pid
lock file = /var/run/rsyncd.lock
log file = /var/log /rsyncd.log
port = 873
secrets file = /etc/rsyncd/server.pass  # 密码文件

# 模块名, 可以配置多个目录
[SYNC]
path = /data/sync
ignore errors
read only = true
list = false
hosts allow = *  # 允许的ip
hosts deny = 0.0.0.0  # 禁止的ip
auth users = syncbackup  # 允许连接的用户
```

```
# /etc/rsyncd/sever.pass
syncbackup:123456

# 文件权限
chmod 600 /etc/rsyncd/server.pass

# 开启防火墙
## /etc/firewalld/services/rsync.xml
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>RSYNC</short>
  <description>rsync.</description>
  <port protocol="tcp" port="873"/>
  <port protocol="udp" port="873"/>
</service>
## 命令
firewall-cmd --permanent --zone=public --add-service=rsync
firewall-cmd --reload

# 启动rsyncd
systemctl start rsyncd
```

### 客户端

```
# /etc/rsyncd/server.pass
123456

# 权限
chmod 600 /etc/rsyncd/server.pass

# 同步命令
rsync -vzrtopg --progress --delete --password-file=/etc/rsyncd/server.pass \
    syncbackup@192.168.1.1::SYNC /data/bak/sync
```
