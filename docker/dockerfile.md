### 构建 go alpine 镜像

```dockerfile
FROM alpine:3.12.1 as builder

COPY --from=golang:1.15-alpine /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"
RUN apk --no-cache add make git gcc libtool musl-dev

COPY go.mod .
COPY go.sum .
RUN  go env -w GOPROXY=https://goproxy.io,direct && go mod download
COPY . .
RUN make; rm -rf $GOPATH/pkg/mod

FROM alpine:3.12.1

RUN sed 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' -i /etc/apk/repositories
RUN apk --no-cache add ca-certificates && rm -rf /var/cache/apk/* /tmp/*

COPY --from=builder /cmd /cmd
EXPOSE 8080
ENTRYPOINT ["/cmd"]

```

Build image: 

```
docker build -t hello/hello:latest .
```



>   注意：关于 mac 的 `docker run --network=host` 却无法直接访问的问题，mac 的 docker 套了一层虚拟机，所以，就算 network 为 host 也是无法直接访问的。

