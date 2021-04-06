
进程管理
- 复制创建 - fork
- 退出 - exit
- 执行 - exec

同步的并发控制
- 信号量 - semaphore
- 管程 - monitor
- 条件变量 - condition variable

进程间通信
- 管道 - pipe
- 信号 - signal
- 事件 - event
- 邮箱 - mailbox
- 共享内存 - shared memory

文件 I/O 操作
- 读 - read
- 写 - write
- 打开 - open
- 关闭 - close

```
| -------------------------------- |
|           Application            |
| -------------------------------- |
|           command line           |
|        compiler/interpreter      |
|          system library          |
| ================================ |
|       system call interface      |
| ================================ |
| Seamphore     | file system       |
| CPU schedule  | Symbol device    |
| Block device  | Virtual memory   |
| Serial driver | Disk driver      |
| ================================ |
|    hardware abstraction layer    |
| ================================ |
|         Serial controller        | 
|         Block controller         |
|         Storage controller       |
|         Terminal equipment       |
|         physical memory          |
|               ...                |
```



内存

我们的程序和数据都是存储在内存中的，存储区域是线性的。

数据的存储但是为 二进制位 (bit), 最小的存储单位为 **字节 (byte)** ，一个 byte 等于 8 个 bit。

内存地址是从 0 开始编号的，自增排列。



中央处理器 (CPU, central process unit)

32 位 和 64 位 的 CPU 最主要的区别在于一次能够计算的字节数量。

32 位一次可以计算 4 字节。

64 位一次可以计算 8 字节。

32 位 和 64 位，通常称为 CPU 的位宽。



CPU 内部还有一些组件，如：

- 寄存器
- 控制单元
- 逻辑运算单元

控制单元负责控制 CPU 工作，逻辑运算单元负责计算，寄存器则种类繁多，每种寄存器的功能不尽相同。不同的 CPU 架构，寄存器也有一些差异。

常见寄存器的种类：

- 通用寄存器 
- 程序计数器
- 指令寄存器

总线

总线是用于 CPU 和内存以及其他设备之间的通信，总线分为 3 种：

- 地址总线，用于指定 CPU 将要操作的内存地址
- 数据总线，用于读写内存的数据
- 控制总线，用于发送和接收信号，比如中断，设备复位信号等，CPU 收到信号，回

