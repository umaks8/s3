export GO15VENDOREXPERIMENT=1

package = github.com/barnybug/s3/cmd/s3
release_version = $(shell git tag --sort=committerdate --list '[0-9]*' | tail -1)
ifeq ($(release_version),)
    $(error Most recent git tag not found)
endif
buildargs = -ldflags '-X github.com/umaks8/s3.version=$(release_version)'

.PHONY: release

default: install

deps:
	go get -d -v ./...

test: deps
	gucumber

install:
	go install -v ./cmd/s3

release:
	mkdir -p release
	GOOS=linux GOARCH=386 go build $(buildargs) -o release/s3-linux-386 $(package)
	GOOS=linux GOARCH=amd64 go build $(buildargs) -o release/s3-linux-amd64 $(package)
	GOOS=linux GOARCH=arm go build $(buildargs) -o release/s3-linux-arm $(package)
	GOOS=linux GOARCH=arm64 go build $(buildargs) -o release/s3-linux-arm64 $(package)
	GOOS=darwin GOARCH=amd64 go build $(buildargs) -o release/s3-darwin-amd64 $(package)
	GOOS=windows GOARCH=386 go build $(buildargs) -o release/s3-windows-386.exe $(package)
	GOOS=windows GOARCH=amd64 go build $(buildargs) -o release/s3-windows-amd64.exe $(package)
