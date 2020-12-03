```makefile
BUILD_DATE=$(shell date +"%Y.%m.%d-%H:%M:%S%Z")
GIT_COMMIT=$(shell git rev-parse --short HEAD 2>/dev/null)
GIT_TAG=$(shell git describe --abbrev=0 --tags --always --match "v*" 2>/dev/null)
VERSION_PKG_PATH=hoo-otc/pkg/version
LDFLAGS=-X $(VERSION_PKG_PATH).BuildDate=$(BUILD_DATE) -X $(VERSION_PKG_PATH).GitCommit=$(GIT_COMMIT)
BUILD_NAME=hoo-user-center
IMAGE_NAME=hoo/$(BUILD_NAME)
IMAGE_TAG=$(GIT_TAG)-$(GIT_COMMIT)
OUTPUT_PATH=./dist
GOPATH=$(shell go env GOPATH)
BUILD_FLAGS=-ldflags="-s -w ${LDFLAGS}"
ifeq ($(DEV), true)
		BUILD_FLAGS += -tags=dev
endif

all: build

run: build
	$(OUTPUT_PATH)/bin/$(BUILD_NAME) -conf=$(OUTPUT_PATH)/configs \
	-log.dir=$(OUTPUT_PATH)/log \
	-appid=$(BUILD_NAME) \


# 生成的 proto
proto = api/api.pb.go api/api.bm.go

build: $(proto)
	go build $(BUILD_FLAGS) -o $(OUTPUT_PATH)/bin/$(BUILD_NAME) cmd/main.go
	cp -r ./locale $(OUTPUT_PATH)/locale
	cp -r ./configs $(OUTPUT_PATH)/configs

docker:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

gen:
	go generate ./...

vet:
	go vet ./...

test: vet
	go test -v ./...

clean:
	#rm -rf $(OUTPUT_PATH)

PROTO_COMMAND = protoc --proto_path=. \
               	--proto_path=$(shell go list -f "{{.Dir}}" -m github.com/go-kratos/kratos)/third_party \
               	--proto_path=${GOPATH}/src

$(proto): api/api.proto
	$(PROTO_COMMAND) --bm_out=. \
	--gofast_out=plugins=grpc:. \
	--gofast_opt=paths=source_relative \
	api/api.proto

swagger:
	$(PROTO_COMMAND) --bswagger_out=:. api/api.proto

.PHONY: run build clean vet test docker gen proto

```


