ARG REGISTRY_PREFIX=""
FROM ${REGISTRY_PREFIX}alf-requirements/bookworm-intel-2024.2:latest

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    git \
    python3-pip \
    python3-venv \
    python3-tk \
    libgfortran5 \
    htop \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER user

# Create Python virtual environment to enable installation via pip
RUN python3 -m venv "/home/user/venv"
ENV PATH="/home/user/venv/bin:$PATH"

RUN pip install \
    f90nml \
    h5py \
    ipympl \
    ipywidgets \
    matplotlib \
    numba \
    numpy \
    pandas \
    scipy \
    tk \
    pyyaml
