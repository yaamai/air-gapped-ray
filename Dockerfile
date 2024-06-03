FROM mcr.microsoft.com/vscode/devcontainers/python:3.11-bullseye

WORKDIR /home/vscode/airgapped-devcontainer
COPY requirements.txt . 
RUN pip install -r requirements.txt

ARG COMMIT_ID=dc96b837cf6bb4af9cd736aa3af08cf8279f7685
ARG TARGETARCH=amd64

WORKDIR /home/vscode/.vscode-server/bin
RUN case ${TARGETARCH} in \
        "amd64") ARCHITECTURE="x64" ;; \
        "arm64") ARCHITECTURE="arm64" ;; \
        *) exit 1 ;; \
    esac && \
    wget https://update.code.visualstudio.com/commit:${COMMIT_ID}/server-linux-${ARCHITECTURE}/stable && tar xf stable && mv vscode-server-linux-${ARCHITECTURE} "${COMMIT_ID}"
RUN chown -R vscode: /home/vscode/.vscode-server

COPY vscode-exts.sh /
RUN mkdir -p /vscode-exts &&\
    bash /vscode-exts.sh &&\
    curl -Lo server-linux-x64 https://update.code.visualstudio.com/commit:dc96b837cf6bb4af9cd736aa3af08cf8279f7685/server-linux-x64/stable &&\
    curl -Lo cli-alpine-x64 https://update.code.visualstudio.com/commit:dc96b837cf6bb4af9cd736aa3af08cf8279f7685/cli-alpine-x64/stable &&\
    curl -Lo win32-x64-user https://update.code.visualstudio.com/commit:dc96b837cf6bb4af9cd736aa3af08cf8279f7685/win32-x64-user/stable
RUN pip install pytest-cov
