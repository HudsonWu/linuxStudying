auditctl是linux用户空间审计系统的最主要部分

1. 命令格式
> auditctl [选项] filter,action -S syscall -F condition -k label

auditctl 命令添加的规则不是永久有效的, 为了让其在重新启动后有效, 可将其添加到文件/etc/audit/rules.d/audit.rules

2. 参数说明
-----------------------------------------------------
项目        可选参数               说明
filter     user,exit,task,exclude  详细说明哪个内核规则应用在事件中
action     always(是),never(否)    是否审核事件
syscall    all,2,open等            所有的系统调用都可以在/usr/include/unistd_64.h文件中找到(syscallent.h)
condition  euid=0,arch=b64         详细说明其他选项, 进一步修改规则来以特定架构、组ID、进程ID和其他内容为基础的事件相匹配
label      任意文字                标记审核事件并检索日志
-----------------------------------------------------
-S 表示系统调用号或名字
-F 表示规则域
-k 表示设置审计规则上的过滤关键词

3. audit审计规则
预配置规则文件: /usr/share/doc/audit-version/

+ 控制规则: 用于更改审计系统本身的配置和设置
可以在/etc/audit/audit.rules中设置, 包括
-D  //删除所有当前装载的审核规则
-b 8192  //在内核中设定最大数量的已存在的审核缓冲区为 8Mb
-e 2  //锁定审核配置

+ 文件系统规则: 文件或目录监视, 可以审核对特定文件或目录的任何类型的访问
可以通过auditctl命令设置, 监控文件系统行为(依靠文件、目录的权限属性来识别)
也可以在/etc/audit/rules.d/audit.rules中设置
-w  路径
-p  权限(如果没有-p选项, 默认监视所有动作rwxa)
-k  关键字
-p权限的动作有四种: r(读取文件或目录)  w(写入文件或目录)  x(运行文件或目录)  a(改变在文件或目录中的属性)
例如:
> auditctl -w /etc/passwd -p wa    //监控/etc/passwd文件的修改行为
> auditctl -w /etc/hosts -p wa -k hosts_change

+ 系统调用规则: 用于监视由任何进程或特定用户进行的系统调用
监控系统调用可能会引起高负荷的日志活动, 要慎重衡量哪些系统调用需要放到audit.rules中
如果审计的是目录, 只能对该目录本身的属性进行审计, 如果想审计下面的文件，需要一一列出
系统调用的监控:
-a  添加一条系统调用监控规则
-S  显示需要监测的系统调用的名称
显示规则和删除规则:
-D  删除所有规则
-d  删除一条规则(和-a对应)
-w  写入文件或者目录
-W  删除一条规则(和-w对应)
-l  列出所有规则
例如:
> auditctl -a always,exit -F arch=b64 -F auid=10001 -S open -k userfile


