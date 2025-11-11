FROM git.physik.uni-wuerzburg.de:25812/z03/pdi/debian:bookworm-gxx

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
    gpg \
    curl \
    ca-certificates \
    zlib1g-dev \
    libaec-dev \
    sudo \
    python3 \
    git \
    && \
    curl https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null \
    && \
    echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list \
    && \
    apt-get update \
    && \
    apt-get install --yes --no-install-recommends \
    intel-oneapi-compiler-fortran \
    intel-oneapi-mkl \
    intel-oneapi-compiler-dpcpp-cpp \
    intel-oneapi-mpi-devel \
    procps \
    # Helper programs for CI tests
    rdfind \
    symlinks \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    useradd -m user && \
    echo '%user ALL = (ALL) NOPASSWD: ALL' > /etc/sudoers.d/user_nopasswd

USER user

# Set environment variables for Intel
ENV TBBROOT=/opt/intel/oneapi/tbb/latest/env/..
ENV ONEAPI_ROOT=/opt/intel/oneapi
ENV PKG_CONFIG_PATH=/opt/intel/oneapi/tbb/latest/env/../lib/pkgconfig:/opt/intel/oneapi/mpi/latest/lib/pkgconfig:/opt/intel/oneapi/mkl/latest/lib/pkgconfig:/opt/intel/oneapi/dpl/latest/lib/pkgconfig:/opt/intel/oneapi/compiler/latest/lib/pkgconfig
ENV ACL_BOARD_VENDOR_PATH=/opt/Intel/OpenCLFPGA/oneAPI/Boards
ENV FPGA_VARS_DIR=/opt/intel/oneapi/compiler/latest/opt/oclfpga
ENV I_MPI_ROOT=/opt/intel/oneapi/mpi/latest
ENV FI_PROVIDER_PATH=/opt/intel/oneapi/mpi/latest/opt/mpi/libfabric/lib/prov:/usr/lib64/libfabric
ENV DIAGUTIL_PATH=/opt/intel/oneapi/debugger/latest/etc/debugger/sys_check/sys_check.py:/opt/intel/oneapi/compiler/latest/etc/compiler/sys_check/sys_check.sh
ENV DPL_ROOT=/opt/intel/oneapi/dpl/latest
ENV MANPATH=/opt/intel/oneapi/mpi/latest/share/man:/opt/intel/oneapi/debugger/latest/share/man:/opt/intel/oneapi/compiler/latest/documentation/en/man/common:
ENV GDB_INFO=/opt/intel/oneapi/debugger/latest/share/info/
ENV SETVARS_COMPLETED=1
ENV CMAKE_PREFIX_PATH=/opt/intel/oneapi/tbb/latest/env/..:/opt/intel/oneapi/mkl/latest/lib/cmake:/opt/intel/oneapi/dpl/latest/lib/cmake/oneDPL:/opt/intel/oneapi/compiler/latest
ENV CMPLR_ROOT=/opt/intel/oneapi/compiler/latest
ENV FPGA_VARS_ARGS=
ENV INFOPATH=/opt/intel/oneapi/debugger/latest/opt/debugger/lib
ENV LIBRARY_PATH=/opt/intel/oneapi/tbb/latest/env/../lib/intel64/gcc4.8:/opt/intel/oneapi/mpi/latest/lib:/opt/intel/oneapi/mkl/latest/lib/:/opt/intel/oneapi/dpl/latest/lib:/opt/intel/oneapi/compiler/latest/lib
ENV OCL_ICD_FILENAMES=libintelocl_emu.so:libalteracl.so:/opt/intel/oneapi/compiler/latest/lib/libintelocl.so
ENV CLASSPATH=/opt/intel/oneapi/mpi/latest/share/java/mpi.jar
ENV INTELFPGAOCLSDKROOT=/opt/intel/oneapi/compiler/latest/opt/oclfpga
ENV LD_LIBRARY_PATH=/opt/intel/oneapi/tbb/latest/env/../lib/intel64/gcc4.8:/opt/intel/oneapi/mpi/latest/opt/mpi/libfabric/lib:/opt/intel/oneapi/mpi/latest/lib:/opt/intel/oneapi/mkl/latest/lib:/opt/intel/oneapi/dpl/latest/lib:/opt/intel/oneapi/debugger/latest/opt/debugger/lib:/opt/intel/oneapi/compiler/latest/opt/oclfpga/host/linux64/lib:/opt/intel/oneapi/compiler/latest/opt/compiler/lib:/opt/intel/oneapi/compiler/latest/lib
ENV MKLROOT=/opt/intel/oneapi/mkl/latest
ENV NLSPATH=/opt/intel/oneapi/mkl/latest/share/locale/%l_%t/%N:/opt/intel/oneapi/compiler/latest/lib/locale/%l_%t/%N
ENV PATH="/opt/intel/oneapi/mpi/latest/opt/mpi/libfabric/bin:/opt/intel/oneapi/mpi/latest/bin:/opt/intel/oneapi/mkl/latest/bin/:/opt/intel/oneapi/dev-utilities/latest/bin:/opt/intel/oneapi/debugger/latest/opt/debugger/bin:/opt/intel/oneapi/compiler/latest/opt/oclfpga/bin:/opt/intel/oneapi/compiler/latest/bin:$PATH"
ENV INTEL_PYTHONHOME=/opt/intel/oneapi/debugger/latest/opt/debugger
ENV CPATH=/opt/intel/oneapi/tbb/latest/env/../include:/opt/intel/oneapi/mpi/latest/include:/opt/intel/oneapi/mkl/latest/include:/opt/intel/oneapi/dpl/latest/include:/opt/intel/oneapi/dev-utilities/latest/include:/opt/intel/oneapi/compiler/latest/opt/oclfpga/include

USER root
ENV ALF_HDF5_DIR="/var/lib/ALF_HDF5"
RUN git clone https://git.physik.uni-wuerzburg.de/ALF/ALF.git /tmp/ALF && \
    cd /tmp/ALF && /bin/sh ./configure.sh intelllvm nompi HDF5 && \
    rm -rf /tmp/ALF /tmp/tmp.*
USER user

