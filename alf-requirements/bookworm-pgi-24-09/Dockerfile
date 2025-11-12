ARG REGISTRY_PREFIX=""
FROM ${REGISTRY_PREFIX}base-imgs/bookworm

ARG YEAR=24
ARG MONTH=9

USER root

RUN apt-get update && \
    apt-get install -y \
    # Needed by OpenMPI
    openssh-client \
    && \
    curl https://developer.download.nvidia.com/hpc-sdk/ubuntu/DEB-GPG-KEY-NVIDIA-HPC-SDK | gpg --dearmor -o /usr/share/keyrings/nvidia-hpcsdk-archive-keyring.gpg && \
    echo 'deb [signed-by=/usr/share/keyrings/nvidia-hpcsdk-archive-keyring.gpg] https://developer.download.nvidia.com/hpc-sdk/ubuntu/amd64 /' | tee /etc/apt/sources.list.d/nvhpc.list && \
    apt-get update -y && \
    apt-get install --yes --no-install-recommends nvhpc-${YEAR}-${MONTH} && \
    rm -rf /opt/nvidia/hpc_sdk/Linux_x86_64/${YEAR}.${MONTH}/examples && \
    rm -rf /opt/nvidia/hpc_sdk/Linux_x86_64/${YEAR}.${MONTH}/profilers && \
    ln -s /opt/nvidia/hpc_sdk/Linux_x86_64/${YEAR}.${MONTH}/compilers/bin/pgfortran /usr/local/bin/pgfortran && \
    ln -s /opt/nvidia/hpc_sdk/Linux_x86_64/${YEAR}.${MONTH}/compilers/bin/nvfortran /usr/local/bin/nvfortran && \
    ln -s /opt/nvidia/hpc_sdk/Linux_x86_64/${YEAR}.${MONTH}/compilers/bin/pgcc /usr/local/bin/pgcc && \
    ln -s /opt/nvidia/hpc_sdk/Linux_x86_64/${YEAR}.${MONTH}/compilers/bin/pgc++ /usr/local/bin/pgc++ && \
    ln -s /opt/nvidia/hpc_sdk/Linux_x86_64/${YEAR}.${MONTH}/comm_libs/openmpi/openmpi-*/bin/mpifort /usr/local/bin/mpifort && \
    ln -s /opt/nvidia/hpc_sdk/Linux_x86_64/${YEAR}.${MONTH}/comm_libs/openmpi/openmpi-*/bin/mpiexec /usr/local/bin/mpiexec && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    echo "alias mpiexec='mpiexec --mca mpi_cuda_support 0'" >> /home/user/.bashrc

ENV ALF_HDF5_DIR="/var/lib/ALF_HDF5"
RUN git clone https://git.physik.uni-wuerzburg.de/ALF/ALF.git /tmp/ALF && \
    cd /tmp/ALF && /bin/sh ./configure.sh pgi nompi HDF5 && \
    rm -rf /tmp/ALF /tmp/tmp.*

USER user
