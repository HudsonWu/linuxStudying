## 基础命令

```
1. 搜索镜像
docker search centos:7
2. 获取镜像
docker pull docker.io/centos
3. 进入容器
  1)新建并进入
docker run -t -i docker.io/centos /bin/bash
docker run --rm -it -p 80:80 vulnerables/web-dvwa
-t选项让Docker分配一个伪终端（pseudo-tty）并绑定到容器的标准输入上
-i则让容器的标准输入保持打开
使用exit可以退出容器
  2) 后台运行容器
docker run -td docker.io/centos
-d后台运行容器并返回容器ID
-p端口映射, 主机(宿主)端口:容器端口
--name="cetnos01", 为容器指定一个名称
  3）进入一个运行中的容器
docker exec -it [container-id] bash
or
docker attach [container-id]
4. 查看本地已有镜像
docker images
5. 将容器保存为一个新的镜像
docker commit [container-id] new_image_name:tag_name
6. 存储镜像
docker save -o centos7.tar docker.io/centos
7. 载入镜像
docker load --input centos7.tar
or
docker load < centos7.tar
将导入镜像以及相关的元数据信息（包括标签等）
8. 终止运行中的容器
1）先使用docker ps -a查看正在运行的容器
2）再使用docker stop来终止正在运行的容器
8. 移除本地镜像
在删除镜像之前先用docker rm 删掉依赖于这个镜像的所有容器
如果是正在运行的容器，需要添加-f参数强制删除
使用docker rmi 删除镜像
9. 上传镜像
docker tag rhel-httpd registry-host:5000/myadmin/rhel-httpd
docker push registry-host:5000/myadmin/rhel-httpd
docker images
</pre>

## 一些实用命令

1. docker容器和主机文件传输
```
docker cp foo.txt mycontainer:/foo.txt
docker cp mycontainer:/foo.txt foo.txt
```
