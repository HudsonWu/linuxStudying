# How to Impose High CPU Load and Stress Test

Examine and monitor the status of linux systems when they are under stress of high load:
> + fine tune activities on a system
> + monitor operating system kernel interfaces
> + test your linux hardware components such as CPU, memory, disk devices and many others to observe their performance under stress
> + measure different power consuming loads on a system

## stress

stress is a workload generator tool designed to subject your system to a configurable measure of CPU, memory, I/O and disk stress

```
//install
apt-get install stress
yum install stress
```

### 语法

stress option argument

+ To spawn N workers spinning on sqrt() function, use the `--cpu N`
+ To spawn N workers spinning on sync() function, use the `--io N`
+ To spawn N workers spinning on malloc()/free() functions, use the `--vm N`
+ To allocate memory per vm worker, use the `--vm-bytes N`
+ Instead of freeing and reallocating memory resources, you can redirty memory by using `--vm-keep`
+ Set sleep to N seconds before freeing memory by using the `--vm-hang N`
+ To Spawn N workers spinning on write()/unlink() functions, use the `--hdd N`
+ Set a timeout after N seconds by using the `--timeout N`
+ Set a wait factor of N microseconds before any work starts by using the `--backoff N`
+ To show more detailed information when running stress, use the `-v`
+ Use `--help` to view help for using stress

### 用法

1. Run the `uptime` command and note down the load average
2. Run the stress command
3. After running stress, again run the uptime command and compare the load average

```console
# uptime
17:20:00 up 7:51, 2 users, load average: 1.91, 2.16, 1.93
# stress --cpu 8 --timeout 20
stress: info: [17246] dispatching hogs: 8 cpu, 0 io, 0 vm, 0 hdd
stress: info: [17246] successful run completed in 21s
# uptime
17:20:24 up 7:51, 2 users, load average: 5.14, 2.88, 2.17
```

```sh
uptime
stress --cpu 4 --io 3 --vm 2 --vm-bytes 256M -v --timeout 30s
uptime
```

## stress-ng

stress-ng is an updated version of the stress workload generator tool which tests your system for following features:
+ CPU compute
+ drive stress
+ I/O syncs
+ Pipe I/o
+ cache thrashing
+ VM stress
+ socket stressing
+ process creation and termination
+ context switching properties

```
//install
apt-get install stress-ng
yum install stress-ng
```

### 语法

stress-ng option argument

+ To start N instances of each stress test, use `--all N`
+ To start N processes to exercises the CPU by sequentially working through all the different CPU stress testing methods, use the `--cpu N`
+ To use a given CPU stress testing method, use `--cpu-method`
+ To stop CPU stress process after N bogo operations, use the `--cpu-ops N`
+ To start N I/O stress testing processes, use the `--io N`
+ To stop io stress processes after N bogo operations, use the `--io-ops N`
+ To start N vm stress testing processes, use the `--vm N`
+ To specify amount of memory per vm process, use `--vm-bytes N`
+ To stop vm stress processes after N bogo operations, use the `--vm-ops N`
+ Use the `--hdd N` to start N harddisk exercising processes
+ To stop hdd stress processes after N bogo operations, use `--hdd-ops N`
+ Set timeout after N seconds: `--timeout N`
+ To generate a summary report after bogo operations, use `--metrics` or `--metrics-brief`, the `--metrics-brief` displays non zero metrics
+ Start N processes that will create and remove directories using mkdir amd rmdir by using the `--dir N`
+ To stop directory operations processes use `--dir-ops N`
+ To start N CPU consuming processes that will exercise the present nice levels, include the `--nice N`, when using this option, every iteration will fork off a child process that runs through all the different nice levels running a busy loop for 0.1 seconds per level and then exits
+ To stop nice loops, use the `--nice-ops N`
+ To start N processes that change the file mode bits via chmod(2) and fchmod(2) on the same file, use the `--chmod N`
+ Stop chmod operations by the `--chmod-ops N`
+ Use the `-v` to display more information about ongoing operations
+ Use `-h` to view help

### 用法

```sh
uptime
stress-ng --cpu 8 --timeout 60 --metrics-brief
uptime
```
```sh
uptime
stress-ng --cppu 4 --cpu-method fft --timeout 2m
uptime
```
```sh
uptime
stress-ng --hdd 5 --hdd-ops 100000
uptime
```
```sh
uptime
stress-ng --cpu 4 --io 4 --vm 1 --vm-bytes 1G --timeout 60s --metrics-brief
uptime
```
