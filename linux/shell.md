## shell 特殊变量

| variable | description                                                  |
| -------- | ------------------------------------------------------------ |
| $$       | 当前 shell 的 pid, 如果是脚本，那么就是当前脚本的 pid        |
| $@       | 脚本参数                                                     |
| $\*      | $\* 在双引号中和 $@ 略有不同，无双引号的时候是相同的，在有双引号的时候，`$*`  回事一个由所有参数组成的字符串。 |
| $#       | 脚本参数个数                                                 |
| $!       | 上一个`后台任务`的进程号                                     |
| $?       | 最后一条命令的退出状态码                                     |
| $0       | 在脚本中表示当前脚本的文件名                                 |
| $n       | 获取脚本的第 n 个参数                                        |

**注意⚠️** 

​		写 shell 用 bash 来解释的话，需要注意几点，变量最好使用双引号(`"`)  括起来，否则会发生奇奇怪怪的问题。数组的 `${array[@]}` 以及 `${array[*]}` 的表现（在双引号内和双引号外），要了解；使用 for 循环一个数组的时候，需要注意使用 `${array[@]}` 而不是 `$array` 或者 `${array[*]}` ，都是错误的做法。

​		分割一个字符串为数组，可以使用如下方法：

```shell
str='a,b,c,d'
OIFS=$IFS
IFS=','
str_arr=($str)
echo ${str_arr[@]}
```

​		合并也可以使用 `IFS` 来合并，不过需要注意的是，用的是 `${array[*]}` ，是 `*` ，不是 `@`：

```shell
IFS=','
echo "${str_arr[*]}"
```



```shell
(( idx++ )) # 这个操作是错误的，应该使用下面这个
(( idx += 1)) 

# 错误例子如下：
idx=0
for i in `seq 10`; do
	(( idx++ ))
	echo $? # 1，这个返回值为 1，如果使用了 set -e ，这里就直接退出了，需要注意⚠️。
done
```



```sh
set -eu
set -o xtrace

# Redirect shell script output to stderr.
exec 1>&2
```



##  `exec`

```sh
exec 2>stderr.log # 将当前的标准错误重定向到 stderr.log 文件中
```



## 运算

#### 对某个数字加一

```sh
$ a=0
$ ((a++))
$ echo $a # 1

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

#### C Style operations

```sh
a=100
((b = a > 100 ? 200 : 50))
echo $b # 50
```

[运算符](https://tldp.org/LDP/abs/html/opprecedence.html)

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

```sh
a=10
if [[ "$a" =~ [0-9] ]]; then # 注意，[0-9]，在 bash 下不要写成 [[ $a =~ "[0-9]" ]] 加了双引号后，会出现非预期的结果。
    echo "ok"
fi
```

## until 语句

直到条件为真时 break，与 `while` 相反

```sh
a=0
until (( a >= 10 )); do
    echo $((a++))
done
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

while read  des what mask iface; do
  echo $des $what $mask $iface
done < <(route -n)
#     ^ ^
#     1 2
# 1. 重定向
# 2. process substitution (相当于创建了一个文件，文件重定向到了 stdin)

route -n > a.txt
while read dst what mask iface; do
  echo $des $what $mask $iface
done < a.txt
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


$ str="hello,world"
$ echo $str | cat

# bad
$ cat < $str

# good
$ cat <<< $str

$ base64 -d <<< aGVsbG8K
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

[变量声明](https://tldp.org/LDP/abs/html/declareref.html)

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


echo ${var:-'default val'} # if var is null or unset, echo 'default val'
echo ${var:='default val'} # if var is null or unset, var is set to the value of default val
echo ${var:?'error msg'}   # if var is null or unset, will print error msg
echo ${var:+'set'}   # if var is set, echo 'set'
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

**生成随机数**

```sh
echo $RANDOM

# 固定范围内的随机数
echo $(($RANDOM % 10)) # 10 以内的随机数
```

## 脚本选项

简单脚本的选项可以通过 `getopts` 来获取

```sh
# getopts.sh
while getopts 'abcde:fgh' OPT; do # abcdfgh 是无参数的 flag，e 是有参数的 flag
  case $OPT in
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

## string operations

```sh
string="hello,world"
echo ${#string} # 11, length of variable string
echo ${string:5} # world
echo ${string:0:5} # hello

echo ${string#hello} # ,world ${string#substring} 从前面匹配字符串
echo ${string%world} # hello, ${string%substring} 从后面匹配字符串

```

## arrays

```sh
arr=(one two three four five five)
echo "arr length: ${#arr[@]}"
echo "arr first element: ${arr[1]}"
echo "arr 1-length: ${arr[@]:1}"
echo "arr 2-3: ${arr[@]:2:3}"

echo ${arr[@]#f*r} # one two three five five; remove four
echo ${arr[@]##t*e} # one two four five five; long match, remove three
echo ${arr[@]/fiv*/foo} # one two three four foo foo
echo ${arr[@]//iv/} # one two three four fe fe

local -a arr=( one two three four '...' )
declare -a before=( one thw three four '...' )
integer # int 类型
float # float 类型

# bash
str='a b c d e f'
IFS=' '
str_arr=($str)
echo ${str_arr[3]}

# join
IFS=':'
echo "${a[*]}" # 

```

## awk

```awk
# awk.sh

BEGIN {
    # FS: regular expression used to separate fields
    # NF: number of fields in the current record
    # NR: ordinal number of current record
    # RS: input record separator
    # FNR: ordinal number of the current record in the current file
    # OFS: output record separator

    FS=":"
    print "hello,world"
}

{
    print "$1: " $1
}

{
    print "\$2: " $2
}

END {
    print "end"
}
```

```sh
$ cat /etc/passwd | awk -f awk.sh
```

## signals

> `kill -l` 列出支持的所有信号

| Signal  | Name | Signal Number Description                                                                           |
| ------- | ---- | --------------------------------------------------------------------------------------------------- |
| SIGHUP  | 1    | Hang up detected on controlling terminal or death of controlling process                            |
| SIGINT  | 2    | Issued if the user sends an interrupt signal (Ctrl + C)                                             |
| SIGQUIT | 3    | Issued if the user sends a quit signal (Ctrl + D)                                                   |
| SIGFPE  | 8    | Issued if an illegal mathematical operation is attempted                                            |
| SIGKILL | 9    | If a process gets this signal it must quit immediately and will not perform any clean-up operations |
| SIGALRM | 14   | Alarm clock signal (used for timers)                                                                |
| SIGTERM | 15   | Software termination signal (sent by kill by default)                                               |



**判断一个命令是否存在**

```
check_cmd() {
	command -v $1 &>/dev/null
}

if check_cmd ping; then
	echo "ping command exist"
fi
```





## 相关文章

[advanced bash script guide](https://tldp.org/LDP/abs/html/index.html)  
[unix special variable](https://www.tutorialspoint.com/unix/unix-special-variables.htm)  
[numeric operators](https://tinylab.gitbooks.io/shellbook/content/zh/chapters/01-chapter2.html)

