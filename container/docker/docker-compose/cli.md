## docker-compose命令

大多数compose命令都是运行一个或多个服务, 如果服务没有指定, 将启动所有服务 <br/>


1. build, 创建或者再建服务
服务被创建后会标记为`project_service`(如`composetest_db`) <br/>
如果改变了一个服务的Dockerfile或者构建目录的内容, 可以使用docker-compose build来重建 <br/>

2. help, 显示命令的帮助和使用信息

3. kill, 通过发送SIGKILL的信号强制停止运行中的容器, 这个信号可以选择行的通过
```
docker-composer kill -s SIGKINT
```

4. logs, 显示服务的日志输出

5. port, 为端口绑定输出公共信息

6. ps, 显示容器

7. pull, 拉取服务镜像

8. rm, 删除停止的容器

9. run, 在服务上运行一个一次性命令
```
docker-compose run web python manage.py shell
```

10. scale, 设置为一个服务启动的容器数量, 数量以"service=num"这样的形式指定
```
docker-compose scale web=2 worker=3
```

11. start, 启动已经存在的容器作为一个服务

12. stop, 停止运行中的容器而不删除它们

13. up, 为一个服务构建, 创建, 启动, 附加到容器
连接的服务会被启动, 除非它们已经在运行了 <br/>
默认情况下, 若服务存在容器的话, docker-compose up会停止并再创建它们 <br/>
(使用了volumes-from会保留已挂载的卷) <br/>
如果不想使容器停止并再创建的话, 使用docker-compose up --no-recreate <br/>

### 选项
<pre>
--verbose, 显示更多输出
--version, 显示版本号并退出
-f, --file FILE, 指定一个可选的Compose yaml文件, 默认docker-compose.yml
-p, --project-name NAME, 指定可选的项目名称, 默认为当前目录名称
</pre>
