# docker-compose



Commands:

- build
- config
- create
- down
- events
- exec
- images
- kill
- logs
- pause
- port
- ps
- pull
- push
- restart
- rm
- run
- scale
- start
- stop
- top
- unpause
- up



**环境变量**

```
.
├── .env
└── docker-compose.yml
```

**.env**

```
TAG=v1.5
```

**docker-compose.yml**

```
version: '3'
services:
  web:
    image: "webapp:${TAG}"
```

使用 docker-compose config 解析 compose 文件：

```
$ docker-compose config
version: '3'
services:
  web:
    image: 'webapp:v1.5'
```

docker-compose config 会自动的获取 `.env` 文件的内容，然后将 compose 文件的变量替换。

也可以通过，export 一个变量达到相同的效果。

```
$ export TAG=v2.0
$ docker-compose config
version: '3'
services:
  web:
    image: 'webapp:v2.0'
```



**使用 `--env-file` 也可以指定环境变量文件**

```bash
docker-compose --env-file ./config/.env.dev up
```

设置容器中的环境变量

```yaml
service:
	web:
		environment:
			- DEBUG
```

可以使用 KV 的方式

```yaml
service:
	web:
		environment:
			PORT: 8080
```

使用 “env_file” 选项直接配置：

```yaml
service:
	web:
		env_file:
			- config.env
```

可以一起使用

```yaml
service:
	web:
		environment:
			- PORT=8080
			- ENV=production
		env_file:
			- config.env
```

