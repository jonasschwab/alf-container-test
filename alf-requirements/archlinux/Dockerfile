FROM archlinux

RUN pacman -Syu --noconfirm && \
    pacman -Sy --noconfirm \
    make \
    gcc-fortran \
    lapack \
    python \
    openmpi \
    curl \
    zlib \
    git \
    sudo \
    && \
    pacman -Sc --noconfirm && \
    useradd -m user && \
    echo '%user ALL = (ALL) NOPASSWD: ALL' > /etc/sudoers.d/user_nopasswd

ENV ALF_HDF5_DIR="/var/lib/ALF_HDF5"
RUN git clone https://git.physik.uni-wuerzburg.de/ALF/ALF.git /tmp/ALF && \
    cd /tmp/ALF && /bin/sh ./configure.sh gnu nompi HDF5 && \
    rm -rf /tmp/ALF /tmp/tmp.*

USER user
