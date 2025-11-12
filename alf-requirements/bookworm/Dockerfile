ARG REGISTRY_PREFIX=""
FROM ${REGISTRY_PREFIX}base-imgs/bookworm

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    libblas-dev \
    liblapack-dev \
    libopenmpi-dev \
    git \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV ALF_HDF5_DIR="/var/lib/ALF_HDF5"
RUN git clone https://git.physik.uni-wuerzburg.de/ALF/ALF.git /tmp/ALF && \
    cd /tmp/ALF && /bin/sh ./configure.sh gnu nompi HDF5 && \
    rm -rf /tmp/ALF /tmp/tmp.*

USER user
