FROM alf-requirements/buster:latest

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    # pyALF dependencies
    git \
    python3-h5py \
    python3-numpy \
    python3-pandas \
    python3-matplotlib \
    python3-numba \
    python3-scipy \
    python3-ipywidgets \
    python3-tk \
    python3-yaml \
    python3-pip \
    python3-venv \
    htop \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER user

# Create Python virtual environment to enable installation via pip
RUN python3 -m venv --system-site-packages "/home/user/venv"
ENV PATH="/home/user/venv/bin:$PATH"

RUN pip install f90nml
