FROM docker.io/debian:bullseye

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    make \
    cmake \
    gfortran \
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
    gpg \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    useradd -m user && \
    echo '%user ALL = (ALL) NOPASSWD: ALL' > /etc/sudoers.d/user_nopasswd

USER user