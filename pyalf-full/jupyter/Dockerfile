FROM pyalf-requirements/jupyter:latest

USER root
RUN mkdir /var/lib/ALF && \
    chown ${NB_UID}:${NB_GID} /var/lib/ALF
USER ${NB_UID}

RUN (cd /var/lib/ALF && \
    git clone --depth 1 https://git.physik.uni-wuerzburg.de/ALF/ALF.git . && \
    git remote set-branches origin '*' && \
    git fetch --depth=1  \
    )
RUN pip install pyALF

ENV ALF_DIR="/var/lib/ALF"
