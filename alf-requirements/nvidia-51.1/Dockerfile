FROM nvcr.io/nvidia/nvhpc:25.1-devel-cuda12.6-ubuntu22.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    python3 \
    # Helper programs for CI tests
    sudo \
    rdfind \
    symlinks \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    useradd -m user && \
    echo '%user ALL = (ALL) NOPASSWD: ALL' > /etc/sudoers.d/user_nopasswd
    # echo "alias mpiexec='mpiexec --mca mpi_cuda_support 0'" >> /home/user/.bashrc

ENV ALF_HDF5_DIR="/var/lib/ALF_HDF5"
RUN git clone https://git.physik.uni-wuerzburg.de/ALF/ALF.git /tmp/ALF && \
    cd /tmp/ALF && /bin/sh ./configure.sh pgi nompi HDF5 && \
    rm -rf /tmp/ALF /tmp/tmp.*

USER user
