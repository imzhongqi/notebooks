### 设计模式



### 装饰器模式（Decorator)



```go
type Object func(int) int

func LogDecorate(fn Object) Object {
  return func (n int) int {
    log.Printf("n=%v\n", n)
    
    result := fn(n)
    
    log.Printf("result=%v\n", result)
 
    return result
  }
}
```



```go
func Double(n int) int {
  return n*2
}

fn := LogDecorate(Double)

fn(2)
// n=2
// result=4

```

