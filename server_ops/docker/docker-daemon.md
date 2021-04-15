官方文档： https://docs.docker.com/config/daemon/



Ubuntu: `/etc/default/docker` 

```
DOCKER_OPTS="-H unix:///var/run/docker.sock -H 0.0.0.0:2375"
```



`/etc/docker/daemon.json`

```
{
  "debug": true,
  "tls": true,
  "tlscert": "/var/docker/server.pem",
  "tlskey": "/var/docker/serverkey.pem",
  "hosts": ["tcp://192.168.59.3:2376"]
}
```



