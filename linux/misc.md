#### 读取 ELF(Executable and Linkable Format) header 信息

```sh
readelf -h <binary_file>
```



```
Mgoogle/protobuf/any.proto=github.com/golang/protobuf/ptypes/any,\                                           
Mgoogle/protobuf/duration.proto=github.com/golang/protobuf/ptypes/duration,\                                           
Mgoogle/protobuf/struct.proto=github.com/golang/protobuf/ptypes/struct,\                                           
Mgoogle/protobuf/timestamp.proto=github.com/golang/protobuf/ptypes/timestamp,\                                           
Mgoogle/protobuf/wrappers.proto=github.com/golang/protobuf/ptypes/wrappers,\                                           
Mgoogle/protobuf/descriptor.proto=github.com/golang/protobuf/protoc-gen-go/descriptor  
```



### 命令行小技巧

less +F 类似 tail -f 

Alt + . 上一个命令的参数

Ctrl-x + Ctrl-e 会打开编辑器来编辑你的命令



### tmux 编译

```
sudo apt install automake
sudo apt install pkg-config
sudo apt install byacc
sudo apt install libevent1-dev
sudo apt install ncurses-term ncurses-hexedit
sudo apt install libncurses5-dev libncursesw5-dev
```





### x86/x86-64

x86 是指 32 位机器

X86_64 是 64 位机器, 也叫 AMD64