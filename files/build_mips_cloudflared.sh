#!/usr/bin/env bash

echo "This script executes the build process for the cloudflared on mips for the Unifi USG and EdgeRouter Platforms"

docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp -e GOOS=linux -e GOARCH=mips golang bash -c "go get -v github.com/cloudflare/cloudflared/cmd/cloudflared; GOOS=linux GOARCH=mips go build -v -x github.com/cloudflare/cloudflared/cmd/cloudflared"
