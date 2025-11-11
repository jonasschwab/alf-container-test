FROM docker.io/debian:trixie

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    make \
    cmake \
    gfortran \
    libopenmpi-dev \
    libopenblas-dev \
    python3 \
    sudo \
    # For downloading and compiling HDF5
    curl \
    zlib1g-dev \
    libaec-dev \
    g++ \
    sudo \
    # Helper programs for CI tests
    rdfind \
    symlinks \
    git \
    ca-certificates \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    useradd -m user && \
    echo '%user ALL = (ALL) NOPASSWD: ALL' > /etc/sudoers.d/user_nopasswd

ENV ALF_HDF5_DIR="/var/lib/ALF_HDF5"
RUN git clone https://git.physik.uni-wuerzburg.de/ALF/ALF.git /tmp/ALF && \
    cd /tmp/ALF && /bin/sh ./configure.sh gnu nompi HDF5 && \
    rm -rf /tmp/ALF /tmp/tmp.*

USER user
