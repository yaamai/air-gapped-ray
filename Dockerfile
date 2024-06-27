# syntax = docker/dockerfile:experimental
FROM docker.io/yaamai/aio-ray-devcontainer:base

WORKDIR /home/vscode/airgapped-devcontainer
COPY requirements.txt . 
RUN --mount=type=cache,target=/root/.cache/pip pip install -r requirements.txt
RUN npm -g install leaflet leaflet-editable pmtiles protomaps-leaflet
RUN TEMP_DEB=$(mktemp) && wget -qO "${TEMP_DEB}" https://gitlab.com/gitlab-org/cli/-/releases/v1.43.0/downloads/glab_1.43.0_Linux_x86_64.deb && dpkg -i ${TEMP_DEB} && rm -f ${TEMP_DEB}
