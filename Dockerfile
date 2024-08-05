# syntax = docker/dockerfile:experimental
FROM docker.io/yaamai/aio-ray-devcontainer:base

WORKDIR /home/vscode/airgapped-devcontainer
COPY requirements.txt . 
RUN --mount=type=cache,target=/root/.cache/pip pip install -r requirements.txt
RUN npm -g install leaflet leaflet-editable pmtiles protomaps-leaflet
RUN TEMP_DEB=$(mktemp) && wget -qO "${TEMP_DEB}" https://gitlab.com/gitlab-org/cli/-/releases/v1.43.0/downloads/glab_1.43.0_Linux_x86_64.deb && dpkg -i ${TEMP_DEB} && rm -f ${TEMP_DEB}
RUN apt-get update && apt-get install -y cloc g++ vim && apt-get clean && rm -rf  /var/lib/apt/lists/*

RUN \
  curl -LO https://archives.boost.io/release/1.85.0/source/boost_1_85_0.tar.bz2 &&\
  tar xf boost_1_85_0.tar.bz2 &&\
  cd boost_1_85_0 &&\
  ./bootstrap.sh --with-libraries=python --with-python=python3 --with-python-version=3.11 &&\
  ./b2 install -j8 &&\
  rm -rf boost_1_85_0 boost_1_85_0.tar.bz2
RUN pip install pytest-sqlalchemy-mock pandas-stubs types-shapely
