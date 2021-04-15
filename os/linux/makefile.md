```makefile
BUILD_DATE = $(shell date +"%Y.%m.%d-%H:%M:%S%Z")
GIT_COMMIT = $(shell git rev-parse --short HEAD 2>/dev/null)
GIT_TAG = $(shell git describe --abbrev=0 --tags --always --match "v*" 2>/dev/null)
VERSION_PKG_PATH = hoo-otc/pkg/version
LDFLAGS = -X $(VERSION_PKG_PATH).BuildDate=$(BUILD_DATE) -X $(VERSION_PKG_PATH).GitCommit=$(GIT_COMMIT)
BUILD_NAME = hoo-user-center
IMAGE_NAME = hoo/$(BUILD_NAME)
IMAGE_TAG = $(GIT_TAG)-$(GIT_COMMIT)
OUTPUT_PATH = ./dist
GOPATH = $(shell go env GOPATH)
BUILD_FLAGS = -ldflags="-s -w ${LDFLAGS}"
protobuf = api/api.pb.go api/api.bm.go api/internal.pb.go

ifeq ($(DEV), true)
	BUILD_FLAGS += -tags=dev
endif


build: $(protobuf)
	go build $(BUILD_FLAGS) -o $(OUTPUT_PATH)/bin/$(BUILD_NAME) cmd/main.go
	cp -r ./locale $(OUTPUT_PATH)/locale
	cp -r ./configs $(OUTPUT_PATH)/configs

run: build
	$(OUTPUT_PATH)/bin/$(BUILD_NAME) -conf=$(OUTPUT_PATH)/configs \
	-log.dir=$(OUTPUT_PATH)/log \
	-appid=$(BUILD_NAME) \

docker:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

gen:
	go generate ./...

vet:
	go vet ./...

test: vet
	go test -v ./...

PROTOC_FLAGS = --proto_path=. \
 	--proto_path=$(shell go list -f "{{.Dir}}" -m github.com/go-kratos/kratos)/third_party \
 	--proto_path=${GOPATH}/src

define PROTOC
	@echo build proto...
	protoc $(PROTOC_FLAGS) --bm_out=. \
	--gofast_out=plugins=grpc:. \
	--gofast_opt=paths=source_relative
endef

api/internal.pb.go: api/internal.proto
	protoc $(PROTOC_FLAGS) --gofast_out=. --gofast_opt=paths=source_relative $<

api/api.pb.go api/api.bm.go: api/api.proto
	$(PROTOC) $?

proto:
	$(PROTOC) api/api.proto

swagger:
	protoc $(PROTOC_FLAGS) --bswagger_out=:. api/api.proto

clean:
	#rm -rf $(OUTPUT_PATH)

.PHONY: run build clean vet test docker gen proto

```



$@：目标的名字

$^：构造所需文件列表所有所有文件的名字

$<：构造所需文件列表的第一个文件的名字

$?：构造所需文件列表中更新过的文件

$*:  获取通配符匹配的值



### Makefile 笔记

makefile 的规则：

```makefile
target ...: prerequisites ...
	command
	...
```

target 可以是一个目标文件

prerequisites 是 一系列为了创建 target 而需要的资源

command 是任意的 shell 命令





比如说编译一个可执行的文件

```
cmd: cmd.go
	go build -o $@ $< 
# $@ 表示 cmd
@ $< 表示 cmd.go
```



**最终执行的目标**

```
install:
	echo $(MAKECMDGOALS)
```



```makefile
BUILD = go build

debug-%: BUILD += -gcflags="all=-N -l"
# go build -gcflags="all=-N -l" main.go
debug-web:
	$(BUILD) main.go

.PHONY: debug-*
```

