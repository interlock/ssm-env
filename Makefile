.PHONY: test build_all clean

BINARY=ssm-env
PLATFORMS=darwin linux
ARCHITECTURES=amd64 arm64 arm

bin/ssm-env: *.go
	CGO_ENABLED=0 go build -o $@ .

build_all:
	$(foreach GOOS, $(PLATFORMS),\
	$(foreach GOARCH, $(ARCHITECTURES), $(shell export GOOS=$(GOOS); export GOARCH=$(GOARCH); export CGO_ENABLED=0; go build -v -o bin/$(BINARY)-$(GOOS)-$(GOARCH))))

test:
	go test -race $(shell go list ./... | grep -v /vendor/)

clean:
	rm -rf bin/*