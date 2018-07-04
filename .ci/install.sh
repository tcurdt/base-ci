#!/bin/bash
set -e

mkdir -p bin

# curl -s https://api.github.com/repos/tcnksm/ghr/releases/latest | jq -r '.assets[] | select(.name | test("linux_amd64.tar.gz"; "ix")) | .browser_download_url'
URL_GHR=https://github.com/tcnksm/ghr/releases/download/v0.10.0/ghr_v0.10.0_linux_amd64.tar.gz

curl -sL $URL_GHR | tar -xz --strip-components=1 -C bin
