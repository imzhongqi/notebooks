### `reflect.Value` 用与表示 go 的值



**Methods list**

#### `func (v Value) Addr() Value`

>   `Addr` 返回一个指针值，表示 `v` 的地址，如果  `CanAddr()`  返回 false，那么调用该方法将会 panic。`Addr`  通常用于获取指向 struct 字段或 slice 元素的指针，以便调用指针接收者的方法。



#### `func (v Value) Call(in []Value) []Value`

#### `func (v Value) CallSlice(in []Value) []Value`

#### `func (v Value) Close()`




#### `func (v Value) Elem() Value`



### 结构体相关方法

#### `func (v Value) NumField() int`

##### `func (v Value) Field(i int) Value`

#### `func (v Value) FieldByIndex(index []int) Value`

>   返回嵌套的字段，嵌套的字段必须为结构体
>
>   比如 ：
>
>   ```go
>   package main
>   
>   import (
>   	"reflect"
>     "fmt"
>   )
>   
>   type A struct {
>   	Name string
>     Age  int
>   }
>   
>   type B struct {
>     A
>   }
>   
>   func main() {
>     v := B{
>       A{ // 0
>         Name: "Tom", // 0
>         Age: 100, // 1
>       },
>     }
>     
>     name := reflect.ValueOf(v).FieldByIndex([]int{0, 0}).Interface()
>     age := reflect.ValueOf(v).FieldByIndex([]int{0, 1}).Interface()
>     fmt.Println(name.(string), age.(int)) // Tom 100
>   }
>   ```

#### `func (v Value) FieldByName(name string) Value`

>   通过字段名称获取结构体字段值

#### `func (v Value) FieldByNameFunc(match func(string) bool) Value`

#### `func (v Value) Method(i int) Value`

#### `func (v Value) MethodByName(name string) Value`



### 获取 v 底层具体类型值相关

#### `func (v Value) Bool() bool`

#### `func (v Value) Bytes() []byte`

#### `func (v Value) Float() float64`

#### `func (v Value) Int() int64`

#### `func (v Value) Pointer() uintptr`

#### `func (v Value) Slice(i int, j int) Value`

#### `func (v Value) Slice3(i int, j int, k int) Value`

#### `func (v Value) String() string`

#### `func (v Value) Uint() uint64`

#### `func (v Value) UnsafeAddr() uintptr`

#### `func (v Value) Complex() complex128`

#### `func (v Value) Interface() interface{}`



#### `func (v Value) Index(i int) Value`



### 获取长度容量

#### `func (v Value) Len() int`

#### `func (v Value) Cap() int`



### map 相关

#### `func (v Value) MapIndex(key Value) Value`

#### `func (v Value) MapRange() *MapIter`



### 检查 v 是否溢出

#### `func (v Value) OverflowComplex(x complex128) bool`

#### `func (v Value) OvrflowFloat(x float64) bool`

#### `func (v Value) OverflowInt(x int64) bool`

#### `func (v Value) OverflowUint(x uint64) bool`



### channel 相关

#### `func (v Value) Recv() (x Value, ok bool)`

#### `func (v Value) Send(x Value)`

#### `func (v Value) TryRecv() (x Value, ok bool)`

#### `func (v Value) TrySend(x Value) bool`



### 设置 v 相关

#### `func (v Value) Set(x Value)`

#### `func (v Value) SetBool(x bool)`

#### `func (v Value) SetBytes(x []byte)`

#### `func (v Value) SetRunes(x []rune)`

#### `func (v Value) SetComplex(x complex128)`

#### `func (v Value) SetFloat(x float64)`

#### `func (v Value) SetLen(n int)`

#### `func (v Value) SetCap(n int)`

#### `func (v Value) SetMapIndex(key Value, elem Value)`

#### `func (v Value) SetUint(x uint64)`

#### `func (v Value) SetPointer(x unsafe.Pointer)`

#### `func (v Value) SetString(x string)`



#### v 的元数据相关

#### `func (v Value) CanAddr() bool`

#### `func (v Value) CanSet() bool`

#### `func (v Value) CanInterface() bool`

#### `func (v Value) IsNil() bool`

#### `func (v Value) IsValid() bool`

#### `func (v Value) IsZero() bool`



#### `func (v Value) Kind() Kind`

#### `func (v Value) Type() Type`

#### `func (v Value) Convert(t Type) Value`









