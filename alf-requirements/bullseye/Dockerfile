FROM git.physik.uni-wuerzburg.de:25812/z03/pdi/debian:bullseye-minbase

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    gfortran \
    make \
    cmake \
    libblas-dev \
    liblapack-dev \
    libopenmpi-dev \
    python3 \
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
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    useradd -m user && \
    echo '%user ALL = (ALL) NOPASSWD: ALL' > /etc/sudoers.d/user_nopasswd

ENV ALF_HDF5_DIR="/var/lib/ALF_HDF5"
RUN git clone https://git.physik.uni-wuerzburg.de/ALF/ALF.git /tmp/ALF && \
    cd /tmp/ALF && /bin/sh ./configure.sh gnu nompi HDF5 && \
    rm -rf /tmp/ALF /tmp/tmp.*

USER user
