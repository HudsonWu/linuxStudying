# cpu显示信息解释

+ us, user cpu time (or) % CPU time spent in user space
+ sy, system cpu time (or) % CPU time spent in kernel space
+ ni, user nice cpu time (or) % CPU time spent on low priority processes
+ id, idle cpu time (or) % CPU time spent idle
+ wa, io wait cpu time (or) % CPU time spent in wait (on disk)
+ hi, hardware irq (or) % CPU time spent servicing/handling hardware interrupts
+ si, software irq (or) % CPU time spent servicing/handling software interrupts
+ st, steal time -- % CPU time in involuntary wait by virtual cpu while hypervisor is servicing another processor (or) % CPU time stolen from a virtual machine

cpu百分比计算方法: 比如一秒内有100个时间片, 这个时间片就是cpu工作的最小单位, 那么这100个cpu时间片在不同的区域和目的进行操作使用, 就代表这个区域所占用的cpu时间比

ni: 每个linux进程都有个优先级, 优先级高的进程有优先执行的权利, 这个叫做pri, 进程除了优先级外, 还有个优先级的修正值, 即比如你原先的优先级是20, 修正值是-2, 那么最后你的进程优先级为18, 这个修正值就叫做进程的nice值. ni是指用作nice加权的进程使用的用户态cpu时间比

hi, si: 如果程序都没什么问题, 是没有hi和si的, 但是实际上有个硬中断和软中断的概念. 比如硬中断, cpu在执行程序时, 突然外设硬件(比如硬盘出现问题了)机器需要立刻通知cpu进行现场保存工作, 这个时候cpu会出现上下文切换, 就是cpu会有一部分时间被硬中断占用, 这个时间就是hi, si是软中断的cpu占用时间, 软中断是由软件的指令方式触发的

st: 是专门对虚拟机来说的, 一台物理机是可以虚拟化出多台虚拟机的, 在其中一台虚拟机上用top查看发现不为0, 说明本来有这么多个cpu时间是安排给这个虚拟机的, 但是由于某种虚拟技术, 把这个cpu时间分配给了其他的虚拟机, 这就叫做偷取

