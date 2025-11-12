ARG REGISTRY_PREFIX=""
FROM ${REGISTRY_PREFIX}pyalf-full/jupyter:latest

# Install Python 3 packages needed for documentation
# RUN mamba install --quiet --yes \
#     'jupyter-book' \
#     'numpydoc' \
#     'sphinx-argparse' \
#     # 'sphinxcontrib-svg2pdfconverter' \
#     && \
#     mamba clean --all -f -y && \
RUN pip install --no-cache-dir \
    'sphinxcontrib-svg2pdfconverter' \
    'jupyter-book' \
    'numpydoc' \
    'sphinx-argparse' \
    && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-xetex \
    texlive-lang-german \
    latexmk \
    xindy \
    fonts-freefont-otf \
    inkscape \
    netcat-openbsd \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# Change Entrypoint to allow CI scripts
ENTRYPOINT [""]
