FROM alf-requirements/tumbleweed:latest

USER root

RUN zypper ref && \
    zypper --non-interactive install \
    htop \
    python313-pip \
    python313-tk \
    && \
    zypper clean

USER user

# Create Python virtual environment to enable installation via pip
RUN python3 -m venv --system-site-packages "/home/user/venv"
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
