```shell
set -ex
source function.sh

# associative array
typeset -A ABC=(
    A 100
    B 200
)
echo ${ABC[A]}

echo `join : a b c d e f g`

func() {
    echo "$#"     # 7
    echo "$*"     # 'a b c d e f g'
    echo "$@"     # a b c d e f g
    echo "$$"     # 当前的进程号
}

func a b c d e f g

[[ `command -v grep` ]] && echo ok   # ok
[ `command -v grep`] && echo ok      # error
```

