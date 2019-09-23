# Upgrade the Linux Kernel on CentOS 7

```
# update and upgrade CentOS 7
yum -y update

# install yum plugin to get faster when installing and updating packages
yum -y install yum-plugin-fastestmirror

# checking the kernel version
cat /etc/redhat-release
cat /etc/os-release
uname -snr

# add ELRepo Repository
## add ELRepo gpg key to the system
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
## add new ELRepo repository with rpm command
rpm -Uvh https://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
## check all repository enabled on the system
yum repolist
yum repolist all

# install New CentOS kernel version
## install ELRepo kernel version with yum command
yum --enablerepo=elrepo-kernel install kernel-ml

# configure Grub2 on CentOS 7
## check all available kernel versions in the Grub2
sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
## configure the default kernel that will run when the system is starting
grub2-set-default 0
## generate the grub2 config with 'grub2-mkconfig' command, then reboot the server
grub2-mkconfig -o /boot/grub2/grub.cfg
reboot
```

## remove an old kernel

```
# install the yum-utils utility
yum install yum-utils

# clean old kernel
package-cleanup --oldkernels
```
