### 查看汇编代码

```sh
go build -gcflags '-l' -o main main.go
go tool objdump -s 'main.main' main
```

```sh
go build -gcflags '-N -l' # -N 禁止编译优化 -l 禁止内联，禁止内联可以减小编译的二进制文件大小
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

