## ssh 

#### ssh 使用代理

ssh 怎么使用代理一直是我很头疼的事情，因为我发现我在命令行下设置 `http_proxy/https_proxy` 亦或者设置 `all_proxy` 环境变量对 git 的 ssh 无效，可以通过下面的设置来使用代理。

`~/.ssh/config` 下配置如下：
```
Host github.com
    ProxyCommand nc -x 127.0.0.1:1080 %h %p
```

-x 后跟着代理地址即可。
