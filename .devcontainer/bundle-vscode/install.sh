#!/bin/bash

export COMMIT_ID=dc96b837cf6bb4af9cd736aa3af08cf8279f7685
export TARGETARCH=amd64

mkdir -p /home/vscode/.vscode-server/bin
cd /home/vscode/.vscode-server/bin

case ${TARGETARCH} in
    "amd64") ARCHITECTURE="x64" ;;
    "arm64") ARCHITECTURE="arm64" ;;
    *) exit 1 ;;
esac

wget -q https://update.code.visualstudio.com/commit:${COMMIT_ID}/server-linux-${ARCHITECTURE}/stable && tar xf stable && mv vscode-server-linux-${ARCHITECTURE} "${COMMIT_ID}"
curl -Lo server-linux-x64 https://update.code.visualstudio.com/commit:${COMMIT_ID}/server-linux-x64/stable
curl -Lo cli-alpine-x64 https://update.code.visualstudio.com/commit:${COMMIT_ID}/cli-alpine-x64/stable
curl -Lo win32-x64-user https://update.code.visualstudio.com/commit:${COMMIT_ID}/win32-x64-user/stable
