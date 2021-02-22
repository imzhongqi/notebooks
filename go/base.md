
### channel

**广播退出**
如果想通知所有的 worker 一起退出的话，可以使用一个 channel 来当信号，直接 close 就好了
```go
package main

import "fmt"

func main() {
	var done = make(chan struct{})
	for i := 0; i < 10; i++ {
		go func(i int) {
			for {
				select {
				case <-done:
					fmt.Println("done id: ", i)
					return
				}
			}
		}(i)
	}

	close(done)
    time.Sleep(1 * time.Millisecond)
}
```