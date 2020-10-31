## ssh 

#### ssh 使用代理

ssh 怎么使用代理一直是我很头疼的事情，因为我发现我在命令行下设置 `http_proxy/https_proxy` 亦或者设置 `all_proxy` 环境变量对 git 的 ssh 无效，可以通过下面的设置来使用代理。

`~/.ssh/config` ：

```
Host <host>
    ProxyCommand nc -x <proxy_address> %h %p
```

此处需要注意，代理必须是 sock 代理，不能使用 http 代理。

```
tee >> ~/.ssh/config << EOF
Host github.com
		ProxyCommand nc -x localhost:1080 %h %p
EOF
```



