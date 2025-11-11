FROM opensuse/tumbleweed

RUN zypper ref && \
    zypper --non-interactive install  \
    make \
    gcc-fortran \
    gcc-c++ \
    lapack-devel \
    python3 \
    openmpi4-devel \
    curl \
    gawk \
    zlib-devel \
    cmake \
    git \
    sudo \
    && \
    zypper clean \
    && \
    echo /usr/lib64/mpi/gcc/openmpi4/lib64/ | tee /etc/ld.so.conf.d/openmpi4.conf \
    && \
    ldconfig \
    && \
    useradd -m user && \
    echo '%user ALL = (ALL) NOPASSWD: ALL' > /etc/sudoers.d/user_nopasswd

ENV PATH="/usr/lib64/mpi/gcc/openmpi4/bin:$PATH"

ENV ALF_HDF5_DIR="/var/lib/ALF_HDF5"
RUN git clone https://git.physik.uni-wuerzburg.de/ALF/ALF.git /tmp/ALF && \
    cd /tmp/ALF && /bin/sh ./configure.sh gnu nompi HDF5 && \
    rm -rf /tmp/ALF /tmp/tmp.*

USER user
