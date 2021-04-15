### 查看汇编代码

```sh
go build -gcflags '-l' -o main main.go
go tool objdump -s 'main.main' main
```

```sh
go build -gcflags '-N -l' # -N 禁止编译优化 -l 禁止内联，禁止内联可以减小编译的二进制文件大小
```



-m 变量逃逸分析

```shell
go run -gcflags='-m' main.go
```





### Race Detection

```sh
go test -race main
go run -race main.go
go build -race mycmd
go install -race mypkg
```



### static analysis

- bad printf formats
- bad build tags
- bad range loop variable use in closures
- useless assignments
- unreachable code
- bad use of mutexes
- and more 

```
go vet [package]
```



### bit hacking 

| 操作符 | 描述                  |
| ------ | --------------------- |
| &      | 按位与（bitwise AND） |
| \|     | 按位或（bitwise OR）  |
| ^      | 按位异（bitwise XOR） |
| &^     | 按位并取反（AND NOT） |
| <<     | 左移（left shift）    |
| >> | 右移动（right shift） |



### 编译 go 时，可以加点料

```go
package main

import (
	"fmt"
)

var (
	buildTime string
	commitHash string
)

func main() {
	fmt.Println(buildTime)
	fmt.Println(commitHash)
}
```

```sh
go build -ldflags "-X main.buildTime=$(date +"%Y.%m.%d.%H%M%S") -X main.commitHash=$(git log --pretty='%h' -n 1)"
```



### go 编译器指令

- `go:nosplit`
- `go:inline`
- `go:linkname`



```sh
go clean --modcache
```



```
go list -m -json -versions github.com/gin-gonic/gin
```



```
GODEBUG=gctrace=1
```



![ch3-2-arch-amd64-01.ditaa](https://chai2010.cn/advanced-go-programming-book/images/ch3-2-arch-amd64-01.ditaa.png)



-   栈区内存是从高地址向低地址增长的

-   堆区内存是从低地址向高地址增长的





### 寄存器

-   **X86寄存器**
    -   FLAGS 状态寄存器
    -   IP 指令寄存器
    -   通用寄存器
        -   AX
        -   BX
        -   CX
        -   DX
        -   SI
        -   DI
        -   BP 记录当前函数帧的开始位置 (和函数调用相关的指令会隐式的影响 `BP` 的值)
        -   SP 当前栈指针的位置 (和栈相关的指令会隐式地影响 `SP` 的值)
        -   R8~R15
-   **Go pseudo registers**
    -   PC Program counter: arguments and locals
    -   FP Frame pointer: jumps and branches
    -   SP Stack pointer:  top of stack, 当前函数栈的底部(不包括参数和返回值部分), SP 是一个比较特殊的寄存器, 因为有一个同名的通用寄存器,区分真伪寄存器是判断是否有标识符和一个偏移量为前缀,没有标识符前缀的则是真的寄存器. 比如: (SP)、+8(SP) 没有标示符前缀的为真寄存器，而 a(SP) 、b+8(SP) 有标识符前缀的是伪寄存器。
    -   SB Static base pointer: global symbols



![ch3-3-arch-amd64-02.ditaa](https://chai2010.cn/advanced-go-programming-book/images/ch3-3-arch-amd64-02.ditaa.png)



![memory](../img/memory.png)



伪SP寄存器对应栈帧的底部（内存更大的地址，因为栈内存是从高到低增长的）。当前栈的顶部对应的是真实存在的SP寄存器，对应的是当前的栈帧的栈顶，对应更小的地址。



### X86-64 指令集

| Data Type | 386/AMD64 | Comment  |
| --------- | --------- | -------- |
| [1]byte   | MOVB      | Byte     |
| [2]byte   | MOVW      | Word     |
| [4]byte   | MOVL      | Long     |
| [8]byte   | MOVQ      | Quadword |


