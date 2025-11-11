FROM alf-requirements/archlinux:latest

USER root

RUN pacman -Sy --noconfirm \
    # pyALF dependencies
    git \
    python-pip \
    python-virtualenv \
    tk \
    htop \
    && \
    pacman -Sc --noconfirm

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
