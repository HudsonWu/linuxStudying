```
UNetbootin 镜像刻录工具
监视网络流量 netspeed
tty支持中文：cce,zhcon或fbterm
```

## NVIDIA显卡驱动
```
1. 将开源的NVIDIA驱动nouveau加入黑名单
/etc/modprobe.d/blacklist.conf
blacklist nouveau
2. 查看当前的系统信息
uname -a
系统：kali  内核版本：4.13.0  系统架构：x86_64
3. 安装linux头文件
aptitude -r install linux-header-$(uname -r)
4. 安装nvidia内核
apt-get install nvidia-kernel-4.13.0-kali1-amd64
5. 安装NVIDIA驱动nvidia-kernel-dkms包
aptitude install nvidia-kernel-dkms
6. 安装NVIDIA显卡驱动应用程序nvidia-xconfig包
aptitude install nvidia-xconfig
7. 生成Xorg服务配置文件
nvidia-xconfig
重启系统
8. 检查NVIDIA显卡驱动是否成功安装
先检查GLX模块
glxinfo | grep -i "direct rendering"
检查nvidia驱动模块
lsmod | grep nvidia
lsmod | grep nouveau
9. 为了加快破解一些大数据文件, 需要安装CUDA(Compute Unified Device Architecture)
CUDA是一种由NVIDIA推出的通用并行计算架构, 该架构使GPU能够解决复杂的计算问题
aptitude install nvidia-cuda-toolkit nvidia-opencl-icd
```
