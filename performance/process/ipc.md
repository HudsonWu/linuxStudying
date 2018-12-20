# IPC, InterProcessCommunication, 进程间通信

每个进程各自有不同的用户地址空间, 任何一个进程的全局变量在另一个进程中都看不到, 所以进程之间要交换数据必须通过内核, 在内核中开辟一块缓冲区, 进程1把数据从用户空间拷到内核缓冲区, 进程2再从内核缓冲区把数据读走, 内核提供的这种机制称为进程间通信(IPC)

## 匿名管道

## FIFO

## mkfifo


## Reference

<https://blog.csdn.net/jnu_simba/article/details/8953960>
