FROM jupyter/base-notebook

ARG tag_name
ARG image_name="base"

USER root


# general OS packages
RUN apt-get update && apt-get install -yq --no-install-recommends \
    # basic packages 
    htop vim emacs unzip git wget axel tmux nano rsync  \
    sshpass lsb-release \
    # sshfs dependencies
    fuse libfuse2 sshfs s3fs \
    # build dependencies for singularity
    build-essential uuid-dev libgpgme-dev squashfs-tools libseccomp-dev \
    pkg-config gcc g++ cryptsetup-bin \
    # base dependencies for general stuff
    libhdf5-dev hdf5-tools libigraph0-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# conda packages
RUN conda install -c conda-forge mamba
RUN mamba install -y \
      jupyter-server-proxy \
      nbresuse \ 
      qtconsole \
      ipywidgets \
      ipykernel \
      -c conda-forge

RUN jupyter labextension install @jupyterlab/server-proxy

# clean conda cache
RUN  mamba clean --index-cache --tarballs --yes

# fix permissions
RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# rclone
RUN RCLONE_DEB=rclone-current-linux-amd64.deb && \
    cd /tmp && \
    wget --quiet https://downloads.rclone.org/$RCLONE_DEB && \
    apt-get install -y /tmp/$RCLONE_DEB && \
    rm /tmp/$RCLONE_DEB

# go
RUN export VERSION=1.15 OS=linux ARCH=amd64 && \
    cd /tmp && \
    wget --quiet https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
    tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz && \
    rm go$VERSION.$OS-$ARCH.tar.gz

ENV PATH=/usr/local/go/bin:$PATH

# singularity
RUN export VERSION=3.6.1 && \
    cd /tmp && \
    wget --quiet https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz && \
    tar -xzf singularity-${VERSION}.tar.gz && \
    rm singularity-${VERSION}.tar.gz && \
    cd /tmp/singularity && \
    ./mconfig && make -C builddir && make -C builddir install && \
    rm -rf /tmp/singularity/

# give jovyan sudo permissions
RUN sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers && \
    echo "jovyan ALL= (ALL) NOPASSWD: ALL" >> /etc/sudoers.d/jovyan

# mount-farm script
COPY mount-farm /usr/local/bin/mount-farm
RUN chmod +x /usr/local/bin/mount-farm

RUN mkdir -p /sanger/ && \
    conda list > /sanger/conda.info && \
    lsb_release -a > /sanger/ubuntu.info && \
    singularity --version > /sanger/singularity.info && \
    rclone --version > /sanger/rclone.info && \
    echo "$image_name-$tag_name" > /sanger/image.info

COPY poststart.sh /poststart/base.sh
RUN chmod +x /poststart/*.sh
