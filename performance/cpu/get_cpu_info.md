# Get CPU Information

## /proc/cpuinfo

```sh
cat /proc/cpuinfo | grep 'vendor' | uniq
cat /proc/cpuinfo | grep 'model name' | uniq
cat /proc/cpuinfo | grep processor | wc -l
cat /proc/cpuinfo | grep 'core id'
```

## lscpu, shows CPU architecture info

The command lscpu prints CPU architecture information from sysfs and /proc/cpuinfo

```
lscpu
```

## cpuid, shows x86 CPU

The command cpuid dumps complete information about the CPU(s) collected from the CPUID instruction, and also discover the exact model of x86 CPU(s) from that information

```
//install
apt-get install cpuid
yum install cpuid

cpuid
```

## dmidecode, Show Linux hardware info

dmidecode is a tool for retrieving hardware information of any linux system

```
dmidecode --type processor
```

## inxi, Show Linux system information

inxi is a powerful command line system information script intended both console and IRC(Internet Relay Chat), you can use it to instantly retrieve hardware information

```
//install
apt-get install inxi
yum install inxi

//To display complete CPU information, use the -C flag
inxi -C
```

## lshw, list hardware configuration

lshw is a minimal tool for gathering in-depth information on the hardware configuration of a computer, you can use the -C option to select the hardware class

```
lshw -C CPU
lshw -short  //print a summary of hardware information
lshw -html > lshw.html
```

## hwinfo, shows present hardware info

hwinfo is used to extract info about hardware present in a linux system, to display info about your CPU, user the --cpu

```
hwinfo --cpu
```

## nproc, print number of processing units

nproc command is used to show the number of processing unit present on your computer

```
nproc
```
