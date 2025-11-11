FROM git.physik.uni-wuerzburg.de:25812/z03/pdi/debian:bullseye-intel-oneapi-ifort-python3

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    intel-oneapi-mpi-devel \
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

USER user

# Set environment variables for Intel
ENV TBBROOT=/opt/intel/oneapi/tbb/latest/env/..
ENV ONEAPI_ROOT=/opt/intel/oneapi
ENV PKG_CONFIG_PATH=/opt/intel/oneapi/tbb/latest/env/../lib/pkgconfig:/opt/intel/oneapi/mpi/latest/lib/pkgconfig:/opt/intel/oneapi/mkl/latest/lib/pkgconfig:/opt/intel/oneapi/compiler/latest/lib/pkgconfig
ENV I_MPI_ROOT=/opt/intel/oneapi/mpi/latest
ENV FI_PROVIDER_PATH=/opt/intel/oneapi/mpi/latest/opt/mpi/libfabric/lib/prov:/usr/lib64/libfabric
ENV DIAGUTIL_PATH=/opt/intel/oneapi/debugger/latest/etc/debugger/sys_check/sys_check.py:/opt/intel/oneapi/compiler/latest/etc/compiler/sys_check/sys_check.sh
ENV MANPATH=/opt/intel/oneapi/mpi/latest/share/man:/opt/intel/oneapi/debugger/latest/share/man:/opt/intel/oneapi/compiler/latest/share/man:
ENV GDB_INFO=/opt/intel/oneapi/debugger/latest/share/info/
ENV SETVARS_COMPLETED=1
ENV CMAKE_PREFIX_PATH=/opt/intel/oneapi/tbb/latest/env/..:/opt/intel/oneapi/mkl/latest/lib/cmake:/opt/intel/oneapi/compiler/latest
ENV CMPLR_ROOT=/opt/intel/oneapi/compiler/latest
ENV INFOPATH=/opt/intel/oneapi/debugger/latest/opt/debugger/lib
ENV LIBRARY_PATH=/opt/intel/oneapi/tbb/latest/env/../lib/intel64/gcc4.8:/opt/intel/oneapi/mpi/latest/lib:/opt/intel/oneapi/mkl/latest/lib/:/opt/intel/oneapi/compiler/latest/lib
ENV OCL_ICD_FILENAMES=/opt/intel/oneapi/compiler/latest/lib/libintelocl.so
ENV CLASSPATH=/opt/intel/oneapi/mpi/latest/share/java/mpi.jar
ENV LD_LIBRARY_PATH=/opt/intel/oneapi/tbb/latest/env/../lib/intel64/gcc4.8:/opt/intel/oneapi/mpi/latest/opt/mpi/libfabric/lib:/opt/intel/oneapi/mpi/latest/lib:/opt/intel/oneapi/mkl/latest/lib:/opt/intel/oneapi/debugger/latest/opt/debugger/lib:/opt/intel/oneapi/compiler/latest/opt/compiler/lib:/opt/intel/oneapi/compiler/latest/lib
ENV MKLROOT=/opt/intel/oneapi/mkl/latest
ENV NLSPATH=/opt/intel/oneapi/mkl/latest/share/locale/%l_%t/%N:/opt/intel/oneapi/compiler/latest/lib/compiler/locale/%l_%t/%N
ENV PATH="/opt/intel/oneapi/mpi/latest/bin:/opt/intel/oneapi/mkl/latest/bin/:/opt/intel/oneapi/dev-utilities/latest/bin:/opt/intel/oneapi/debugger/latest/opt/debugger/bin:/opt/intel/oneapi/compiler/latest/bin:$PATH"
ENV INTEL_PYTHONHOME=/opt/intel/oneapi/debugger/latest/opt/debugger
ENV CPATH=/opt/intel/oneapi/tbb/latest/env/../include:/opt/intel/oneapi/mpi/latest/include:/opt/intel/oneapi/mkl/latest/include:/opt/intel/oneapi/dev-utilities/latest/include
ENV _=/usr/bin/env

USER root
ENV ALF_HDF5_DIR="/var/lib/ALF_HDF5"
RUN git clone https://git.physik.uni-wuerzburg.de/ALF/ALF.git /tmp/ALF && \
    cd /tmp/ALF && /bin/sh ./configure.sh intel nompi HDF5 && \
    rm -rf /tmp/ALF /tmp/tmp.*
USER user

