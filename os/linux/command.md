# linux 常用命令

- **lsof**
- **ss**
- **netstat**
- **top**
- **ps**
- cut
- **grep**
- **awk**
- **sed**
- **find**
- scp
- **tr**
- chsh
- curl
- wget
- diff
- dig
- du
- env
- file
- free
- getopt
- id
- iconv
- info
- install
- json_pp
- jsondiff
- killall
- last
- lastlog
- locale
- lsb_release
- lscpu
- make
- man
- mdig
- printf
- rsync
- seq
- sdiff
- sftp
- sha1sum
- sha224sum
- sha265sum
- shasum
- size
- sort
- split
- ssh
- ssh-add
- ssh-agent
- ssh-copy-id
- ssh-import-id-gh
- ssh-import-id-lp
- ssh-keygen
- ssh-keyscan
- stat
- **stow**
- strace
- strip
- sum
- tail
- tee
- time
- tmux
- timeout
- tty
- uniq
- unlink
- w
- wall
- watch
- wc
- whatis
- whereis
- which
- who
- whoami
- wifi-status
- www-browser
- X11
- xargs
- xauth
- xkill
- xprop
- xz
- xxd
- xzdiff
- xzgrep
- xzless
- xzmore
- zdump
- zipgrep
- zipinfo
- yes
- rgrep
- egrep
- ip
- init
- halt
- mount
- bzcat
- cat
- chmod
- chown
- cp
- date
- dd
- df
- dir
- echo
- false
- fgrep
- less
- ln
- ls
- mkdir
- more
- mv
- nc
- ping
- pwd
- rm
- rmdir
- read
- sleep
- su
- sync
- tar
- touch
- true
- umount
- uname
- zcat
- zcmp
- zdiff
- zegrep
- zfgrep
- zgrep
- zless
- zmore
- znew
- mkfifo
- ip
- route
- swapoff
- swapon
- eval
- exec
- **sshfs**
- **dtrace**
- **ngrep**
- slabtop



#### 命令行小技巧

```
$ echo 1 2 3 4 5 6
$ echo !!
echo 1 2 3 4 5 6
$ echo !!:1  # 选择上一个命令的第2个参数
1
$ echo !^ # 上一个命令的第一个参数
$ echo !$ # 上一个命令的最后一个参数
$ !! # 重复执行上一条命令
```



**创建一个指定大小的文件**

```
$ dd if=/dev/zero of=a.txt bs=1 count=10 # if: in file of: out file bs: byte size
```



**检测网络**

```
$ traceroute baidu.com
traceroute to baidu.com (220.181.38.148), 30 hops max, 60 byte packets
 1  192.168.0.1  0.963 ms  0.960 ms  1.249 ms
 2  192.168.1.1  2.405 ms  2.093 ms  2.388 ms
 3  113.110.224.1  11.893 ms  11.891 ms  25.864 ms
 4  119.145.223.29  13.048 ms  13.049 ms 202.105.153.233  11.579 ms
 5  183.56.65.45  5.561 ms 14.147.127.1  7.942 ms 202.105.158.42  11.495 ms
 6  202.97.34.214  41.276 ms 202.97.22.149  38.065 ms 202.97.34.214  40.493 ms
 7  36.110.248.206  40.463 ms 36.110.245.38  39.613 ms 36.110.246.10  39.306 ms
 8  * 36.110.249.58  44.064 ms *
 9  * * *
10  * 220.181.17.90  41.372 ms *
```

​	记录的是每一跳的 IP 地址，以及到达这一跳花费的时间。



**strace**

追踪程序的系统调用

```
strace ls # 输出 ls 调用的系统调用信息
```



**ip**



**netstat** 

netstat 来自 net-tools 包。



**ping**

```
$ apt install iputils-ping
```



**ifconfig**

ifconfig 来自 net-tools



**ss**

ss 是 netstat 的替代。

```
ss -nt 
```



**lsof**



**dd**

通过指定源文件，创建一个指定大小的文件



**df(display free)**

显示磁盘信息



**du(display usage)**

 查看大小的

