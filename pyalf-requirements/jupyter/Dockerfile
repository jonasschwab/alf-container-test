FROM quay.io/jupyter/scipy-notebook:latest

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    # Minimal dependencies for ALF
    make \
    gfortran \
    libblas-dev \
    liblapack-dev \
    # MPI
    libopenmpi-dev \
    # For testsuite
    cmake \
    # For downloading and compiling HDF5
    curl \
    zlib1g-dev \
    libaec-dev \
    g++ \
    # htop is nice to have 
    htop \
    # So is zsh
    zsh \
    # and vim
    vim \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV ALF_HDF5_DIR="/var/lib/ALF_HDF5"
RUN git clone https://git.physik.uni-wuerzburg.de/ALF/ALF.git /tmp/ALF && \
    cd /tmp/ALF && /bin/sh ./configure.sh gnu nompi HDF5 && \
    rm -rf /tmp/ALF /tmp/tmp.*

USER ${NB_UID}

# Install Python 3 packages
RUN mamba install --yes \
    'jupyter-collaboration' \
    'jupyterlab-git' \
    'h5py' \
    'numpy' \
    'pandas' \
    'matplotlib' \
    'numba' \
    'scipy' \
    'ipywidgets' \
    'ipympl' \
    'f90nml' \
    && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}

WORKDIR "${HOME}"
