## ssh 

#### ssh 使用代理

ssh 怎么使用代理一直是我很头疼的事情，因为我发现我在命令行下设置 `http_proxy/https_proxy` 亦或者设置 `all_proxy` 环境变量对 git 的 ssh 无效，可以通过下面的设置来使用代理。

`~/.ssh/config` ：

```
Host <host>
    ProxyCommand nc -x <proxy_address> %h %p
```

此处需要注意，代理必须是 socks 代理，不能使用 http 代理。

```
tee >> ~/.ssh/config << EOF
Host github.com
		ProxyCommand nc -x localhost:1080 %h %p
EOF
```



```config
Host gitlab.com github.com
    ProxyCommand eval 'nc -z 127.0.0.1 1081 2> /dev/null && nc -x 127.0.0.1:1081 %h %p || nc %h %p'
```





#### ssh 端口转发

如果需要绑定 0.0.0.0 的 ip， 需要配置 `/etc/ssh/sshd_config` ，否则只能绑定回环地址。

```
GatewayPorts yes
```



```sh
Host database
    HostName db.example.com
    LocalForward 3306 localhost:9999
    RemoteForward 6999 localhost:8080
```

```
ssh database
```

打开本地 3306 端口，转发到远程的 localhost:9999 上去，打开远程的 6999端口，转发到本地的 8080 端口上去。



#### 多共享连接：

`~/.ssh/config`

```
ControlMaster auto
ControlPath /tmp/%r@%h:%p
```



#### 禁用密码登录

`/etc/ssh/sshd_config`

```
PasswordAuthentication no
ChallengeResponseAuthentication no
```



#### 保持连接

客户端设置（`~/.ssh/config`）

```
Host *
	ServerAliveInternal 108
```

服务端 （`/etc/ssh/sshd_config`)

```
ClientAliveInterval 180
```



#### ssh 参数

| arg  | description                                                  |
| ---- | ------------------------------------------------------------ |
| -q   | quiet 模式，忽视把部分的警告和诊断信息（比如端口转发时的各种连接错误） |
| -T   | 禁用 tty 分配 （pseudo-terminal allocation)                  |
| -N   | 不执行远程命令（转梦做端口转发）                             |
| -f   | 登录成功后即转为后台任务执行                                 |
| -n   | 重定向 stdin 为 `/dev/null`, 用于配合 -f 后台任务            |
| -L   | LocalForward                                                 |
| -R   | RemoteForward                                                |





```
ssh-copy-id -i ~/.ssh/id_rsa.pub server
```



关闭 root 登录，以及禁止密码登录：

```
PermitRootLogin no
PasswordAuthentication no
```





相关文章：

https://cherrot.com/tech/2017/01/08/ssh-tunneling-practice.html

https://deepzz.com/post/how-to-setup-ssh-config.html

https://askubuntu.com/questions/48129/how-to-create-a-restricted-ssh-user-for-port-forwarding

https://en.wikibooks.org/wiki/OpenSSH/Cookbook/Proxies_and_Jump_Hosts