```makefile
BUILD_DATE=$(shell date +"%Y.%m.%d-%H:%M:%S%Z")
GIT_COMMIT=$(shell git rev-parse --short HEAD 2>/dev/null)
GIT_TAG=$(shell git describe --abbrev=0 --tags --always --match "v*" 2>/dev/null)
VERSION_PKG_PATH=hoo-otc/pkg/version
LDFLAGS=-X $(VERSION_PKG_PATH).BuildDate=$(BUILD_DATE) -X $(VERSION_PKG_PATH).GitCommit=$(GIT_COMMIT)
BUILD_NAME=hoootc
IMAGE_NAME=hoo/$(BUILD_NAME)
IMAGE_TAG=$(GIT_TAG)-$(GIT_COMMIT)
OUTPUT_PATH=./bin
GOPATH=$(shell go env GOPATH)

all: build

run: build
	$(OUTPUT_PATH)/$(BUILD_NAME) -conf=./configs -log.dir=./log

build:
	go build -ldflags="-s -w ${LDFLAGS}" -o $(OUTPUT_PATH)/$(BUILD_NAME) cmd/main.go

docker:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

gen:
	go generate ./...

vet:
	go vet ./...

test: vet
	go test -v ./...

clean:
	rm -rf $(OUTPUT_PATH)


PROTO_COMMAND = protoc --proto_path=. \
               	--proto_path=$(shell  go list -f "{{.Dir}}" -m github.com/go-kratos/kratos)/third_party \
               	--proto_path=${GOPATH}/src

proto:
	$(PROTO_COMMAND) --bm_out=. \
	--gofast_out=plugins=grpc:. \
	--gofast_opt=paths=source_relative \
	api/api.proto


swagger:
	$(PROTO_COMMAND) --bswagger_out=:. api/api.proto

.PHONY: run build clean vet test docker gen proto

```

