## shell 特殊变量

| variable | description                                                                |
| -------- | -------------------------------------------------------------------------- |
| $$       | 当前 shell 的 pid, 如果是脚本，那么就是当前脚本的 pid                      |
| $@       | 脚本参数                                                                   |
| $\*      | $\* 在双引号中和 $@ 略有不同，无双引号的时候是相同的，获取所有的命令行参数 |
| $#       | 脚本参数个数                                                               |
| $!       | 上一个`后台任务`的进程号                                                   |
| $?       | 最后一条命令的退出状态码                                                   |
| $0       | 在脚本中表示当前脚本的文件名                                               |
| $n       | 获取脚本的第 n 个参数                                                      |

## 运算

#### 对某个数字加一

```sh
$ a=0
$ ((a++)) # 1

$ let b++       # let 如果一个变量不存在的话，默认将是 0
$ echo $b # 1

$ c=1
$ c=$(expr $c + 1) # expr 计算的时候要注意空格($c + 1 之间必须有空格)，乘法要转义(\*)
$ echo $c # 2

$ d=1
$ echo $d 1 | awk '{print $1 + $2}'

$ echo $((1+1)) # 2
```

#### 进制转换

```sh
$ echo 'obase=16; ibase=10; 15' | bc -l # F

# 二进制转 10 进制
$ echo $((16#f)) # 15, 二进制的 `1111` 转换为 10 进制
```

如果需要进行进制之间的互相转换，使用 bc 会比较灵活，它可以指定源进制（ `ibase` ），以及目标进制（ `obase` ）

#### 浮点数运算

> expr 无法进行浮点数运算，其他的像 awk、bc、let 可以进行浮点运算

```sh
echo 'scale=3; 1/3' | bc # output: .333
```

## if 语句

```sh
a=20
if (( $a >= 20 )); then
  echo "a greater than 20"
fi
# output: a greater than 20

name="guest"
if [[ "$1" == "" ]]; then
  name="$1"
fi
echo $name

opt=1
if [[ $opt == 1 ]]; then
  echo "opt is 1"
elif [[ $opt == 2 ]]; then
  echo "opt is 2"
else
  echo "else case"
fi
```

## until 语句

```sh

```

## for 语句

```sh
for ((i=0; i<10; i++)); do
  echo "index: $i"
done
# output: 0 1 2 3 4 5 6 7 8 9


for i in {1..10..2}; do
  echo "index: $i"
done
# output: 1 3 5 7 9

for i in `seq 1 2 10`; do
  echo "index: $i"
done
# output: 1 3 5 7 9
```

## while 语句

```sh
a=0
while [ $a -lt 10]; do
  echo $a
  ((a++))
done

line_num=0
cat /etc/passwd | while read line; do # 利用 read 会读取 '\n' 特性，来一次读取一行
  ((line_num++))
  printf "%3s: %s\n" $line_num $line
done
```

## switch（case）语句

```sh
case $1 in
  a)       # 接受 a
    echo "a"
    ;;
  b|c)     # 接受 b 或 c
    echo "b or c"
    ;;
  ?)       # 接受任意一个字符
    echo "chat default case"
    ;;
  *)       # 接受任意的字符或字符串
    echo "default case"
    ;;
esac
```

## here documents

> NOTE: hereDocs 语法并不能作为变量赋值

```sh
cat <<EOF
  START
  1
  2
  3
  4
  5
  END
EOF

# 忽略前面的空格
cat <<-EOF
  START
  1
  2
  3
  4
  5
  END
EOF
```

## linux 查看进程 pid

```sh
$ sleep 10000 &
$ pidof sleep
17465
$ cat /proc/17465/cmdline
sleep10000
```

## 变量

```sh
local -a arr # 声明一个类型为 array 的变量
typeset -A arr = (
  name
)
```

**默认值变量**

```sh
say_hello() {
  echo "hello, ${1:-'guest'}"
}

say_hello # hello, guest
say_hello skywalker # hello, skywalker
```

**函数(方法、命令)**

```sh
cmd() {
  echo "cmd function"
}

function cmd2() {
  echo "cmd2"
}

# 同时定义多个函数
a b c () {
  echo "$0 function"
}

function d e f () {
  echo "this is $0 function"
}

# 立刻执行的函数，可产生作用域，可以使用 local 来声明变量
() {
  local local_variable="hello"
  echo "local variable: $local_variable"
  echo "this is the immediate execution function"
}
echo $local_variable # $local_variable == ''
```

## 脚本选项

简单脚本的选项可以通过 `getopts` 来获取

```sh
# getopts.sh
while getopts 'abcde:fgh' opt; do # abcdfgh 是无参数的 flag，e 是有参数的 flag
  case $opt in
    a)
      echo "flag a is true"
      ;;
    b)
      echo "flag b is true"
      ;;
    c|d)
      echo "flag c or d is true"
      ;;
    e)
      echo "e flag is enable, value is: $OPTARG"
      ;;
    *)
      echo "other flag"
      ;;
  esac
done
```

## 相关文章

[advanced bash script guide](https://tldp.org/LDP/abs/html/index.html)  
[unix special variable](https://www.tutorialspoint.com/unix/unix-special-variables.htm)  
[numeric operators](https://tinylab.gitbooks.io/shellbook/content/zh/chapters/01-chapter2.html)
