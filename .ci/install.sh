#!/bin/bash
set -e

mkdir -p bin

curl -sL `curl -s https://api.github.com/repos/tcnksm/ghr/releases/latest | jq -r '.assets[] | select(.name | test("linux_amd64.tar.gz"; "ix")) | .browser_download_url'` | tar -xz --strip-components=1 -C bin
