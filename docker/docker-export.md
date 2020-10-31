# docker 映射 TCP 端口

[原地址](https://docs.docker.com/config/daemon/) 

```sh
vim /etc/systemd/system/docker.service
```

写入如下内容:
```conf
[Unit]
Description=docker

[Service]
# Environment="HTTP_PROXY=http://proxy.example.com:80" # 配置代理
ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375
```

然后执行：
```sh
systemctl daemon-reload
systemctl restart docker.service
```