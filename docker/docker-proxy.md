# 设置 docker 的代理服务器

如果是私有的镜像，可能用 docker 加速器没法加速，可以使用自己的梯子来加速，
详细可以看[这里](https://docs.docker.com/network/proxy/)。

[dockerd 代理设置](https://docs.docker.com/config/daemon/systemd/)

```json
{
  "proxies": {
    "default": {
      "httpProxy": "http://127.0.0.1:3001",
      "httpsProxy": "http://127.0.0.1:3001",
      "noProxy": "*.test.example.com,.example2.com"
    }
  }
}
```
