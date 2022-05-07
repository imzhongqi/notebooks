## zsh 入门笔记

### variable

#### 变量定义

```sh
# 等号两端不能够有空格 !
num1=1
num2=3.1415926

# 如果字符串中有特殊字符和空格，需要用引号
str1='hello,word'

# 字符串中使用变量要用双引号
str2="number: $num1"

# 使用转义字符，单双引号都可以
str3='hello\nworld'

echo $((num1+num2))

```

#### 变量比较

```sh
# 用于比较数值，如果真返回0，假返回 1
(( ))

((0)) # 假，返回1

a=100
b=200
((c = a > b ? a : b))
echo $c # 200

((a < b && c == b)) # true

# 字符串比较
[[ ]]

str1=hello
str2=world


# 此处注意空格 ！！！
[[ $str1 == $str2 ]] && echo "equal" || echo "not equal"
```

### 语句

可以定义函数，使用 which 来查看，zsh 的语法会被翻译成 posix sehll 的语法。

```sh
$ a() {
    if (($1 > 1)) {
        echo "yes"
    } else {
        echo "no"
    }
}

$ which a
a () {
        if (($1 > 1))
        then
                echo "yes"
        else
                echo "no"
        fi
}
```

#### if

注意，最好不要使用 `[[ ]]` 来比较数值，若是一个不小心，
转换成了字符串比较，会出现奇怪的 bug，很难排查。

```sh
if [[ ]] {
} elif [[ ]] {
} else {
}
```

```sh
str=first
if [[ $str == "first" || $str == "second" ]] {
    echo "good, $str"
}
```

```sh
num1=200
num2=300
if ((num1 > 100 && num2 > 200)) {
    echo "num1: $num1, num2: $num2"
}
```

{ } 用于在当前 shell 运行命令并且判断运行结果。

```sh
if { } {

}
```

```sh
if {command -v vim >/dev/null} {
    echo "vim is exist"
}
```

( ) 用于在子 shell 运行命令并且判断运行结果，用法和 {} 类似，不再举例。

```sh
if ( ) {

}
```

#### 循环

```sh
while [[ ]] {
    break/continue
}
```

```sh
until [[ ]] {

}
```

```sh
for i () {

}
```

```sh
for (( i=0; i<10; i++)) {
    echo "hello: $i"
}

for i ({1..10}) {
    echo "hello: $i"
}
```

```sh
repeat 10 {
    echo "hello"
}
```
