# 手动配置服务

# 在 /etc/systemd/system/ 目录下新建 autossh.service
autossh 为服务名称, autossh 是一款 ssh 工具，可以自动连接远程的机器，做内网穿透。
写入如下内容：

```conf
[Unit]
Description=docker

[Service]
# Environment="HTTP_PROXY=http://proxy.example.com:80" # 配置代理
ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375
```