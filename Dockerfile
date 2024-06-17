# syntax = docker/dockerfile:experimental
FROM mcr.microsoft.com/vscode/devcontainers/python:3.11-bullseye

ARG COMMIT_ID=dc96b837cf6bb4af9cd736aa3af08cf8279f7685
ARG TARGETARCH=amd64

COPY vscode-exts.sh /
WORKDIR /home/vscode/.vscode-server/bin
RUN case ${TARGETARCH} in \
        "amd64") ARCHITECTURE="x64" ;; \
        "arm64") ARCHITECTURE="arm64" ;; \
        *) exit 1 ;; \
    esac && \
    wget -q https://update.code.visualstudio.com/commit:${COMMIT_ID}/server-linux-${ARCHITECTURE}/stable && tar xf stable && mv vscode-server-linux-${ARCHITECTURE} "${COMMIT_ID}" &&\
    bash /vscode-exts.sh &&\
    curl -Lo server-linux-x64 https://update.code.visualstudio.com/commit:${COMMIT_ID}/server-linux-x64/stable &&\
    curl -Lo cli-alpine-x64 https://update.code.visualstudio.com/commit:${COMMIT_ID}/cli-alpine-x64/stable &&\
    curl -Lo win32-x64-user https://update.code.visualstudio.com/commit:${COMMIT_ID}/win32-x64-user/stable
RUN chown -R vscode: /home/vscode/.vscode-server

WORKDIR /home/vscode/airgapped-devcontainer
COPY requirements.txt . 
RUN --mount=type=cache,target=/root/.cache/pip pip install -r requirements.txt
