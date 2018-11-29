# systemctl 

> service --status-all  //列出所有System V控制的服务

## systemd service management

### 列出服务单元
//列出运行中的unit列出
> systemctl list-units
> systemctl

//列出所有加载失败的unit
> systemctl list-units --failed
> systemctl --failed

//列出所有unit, 包括没有找到配置文件的或者启动失败的
> systemctl list-units --all  

//列出所有没有运行的unit
systemctl list-units --all --state=inactive

//列出所有正在运行、类型为service的unit
systemctl list-units --type=service

### 查看服务状态
enabled  已建立启动链接
disabled  没建立启动链接
static   该配置文件没有[Install]部分(无法执行),只能作为其他配置文件的依赖
masked    该配置文件被禁止启动链接

> systemctl status  //显示系统状态
> systemctl status httpd.service  //显示指定服务的状态
> systemctl is-active httpd.service  //查看服务是否激活
> systemctl is-enable sshd.service  //查看服务是否自启
> systemctl cat docker.service  //查看unit配置文件内容
> systemctl list-unit-files  //查看自启动服务
> systemctl list-dependencies sshd.service  //查看依赖
> systemctl -H root@rhel7.example.com status httpd.service  //显示远程主机的某个unit的状态

### unit的管理
//立即启动一个服务
> systemctl start apache.service
//立即停止一个服务
systemctl stop apache.service
//重启一个服务
> systemctl restart apache.service
//杀死一个服务的所有子进程
> systemctl kill apache.service
//重新加载一个服务的配置文件
> systemctl reload apache.service
//重新加载所有修改过的配置文件
> systemctl daemon-reload
//显示某个unit的所有底层参数
> systemctl show httpd.service
//显示某个unit指定属性的值
> systemctl show -p CPUShares httpd.service
//设置某个unit的指定属性
> systemctl set-property httpd.service CPUShares=500

### 查看unit的依赖关系
//列出一个unit的所有依赖，默认不会列出target类型
> systemctl list-dependencies nginx.service
> 列出一个unit的所有依赖，包括target类型
> systemctl list-dependencies --all nginx.service

### 服务的生命周期
1. 服务的激活
systemctl enable : 在/etc/systemd/system/ 建立服务的符号链接，指向/usr/lib/systemd/system/中
systemctl start : 依次启动定义在unit文件中的ExecStartPre、ExecStart和ExecStartPost命令
2. 服务的启动和停止
systemctl start
systemctl stop
systemctl restart
systemctl kill
3. 服务的开机启动和取消
systemctl enable
systemctl disable
4. 服务的修改和移除
systemctl daemon-reload : Systemd 会将 Unit 文件的内容写到缓存中，因此当 Unit 文件被更新时，需要告诉 Systemd 重新读取所有的 Unit 文件
systemctl reset-failed : 移除标记为丢失的 Unit 文件。在删除 Unit 文件后，由于缓存的关系，即使通过 daemon-reload 更新了缓存，在 list-units 中依然会显示标记为 not-found 的 Unit

### targets
> systemctl get-default
> systemctl set-default <target-name>

> systemctl set-default multi-user.target
(相当于在/etc/inittab里面设置为init 3 level)
> systemctl set-default graphical.target 
