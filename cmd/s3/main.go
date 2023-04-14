package main

import (
	"os"

	"github.com/umaks8/s3"
)

func main() {
	exitCode := s3.Main(nil, os.Args, os.Stdout)
	os.Exit(exitCode)
}
