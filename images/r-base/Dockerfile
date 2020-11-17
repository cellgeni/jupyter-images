ARG tag_name
ARG parent_image="base"
ARG registry="quay.io/prete/docker-jupyter"

FROM ${registry}:${parent_image}-${tag_name}

ARG tag_name
ARG image_name="r-base"
ARG rstudio_version="1.2.5019"

USER root

# general OS packages
RUN apt-get update -y -qq 

# R dependecies
RUN apt-get install -y -qq --no-install-recommends \
    libgsl0-dev libxml2-dev libboost-all-dev libssl-dev libhdf5-dev unzip curl libudunits2-dev libgdal-dev libgeos-dev libproj-dev \
    build-essential xorg-dev libreadline-dev libc6-dev libclang-8-dev zlib1g-dev libbz2-dev liblzma-dev libcurl4-openssl-dev libcairo2-dev \
    libpango1.0-dev tcl-dev tk-dev openjdk-8-jdk gfortran

# RStudio dependencies
# https://github.com/rstudio/rstudio/tree/master/dependencies/linux
RUN apt-get install -y -qq --no-install-recommends \
    gdebi-core ant   build-essential   clang   cmake   debsigs   dpkg-sig   expect   fakeroot   gnupg1   libacl1-dev   libattr1-dev   libbz2-dev   libcap-dev   libclang-6.0-dev   libclang-dev   libcurl4-openssl-dev   libegl1-mesa   libfuse2   libgl1-mesa-dev   libgtk-3-0   libpam-dev   libpango1.0-dev   libpq-dev   libsqlite3-dev   libssl-dev   libuser1-dev   libxslt1-dev   lsof   ninja-build   patchelf   pkg-config  psmisc  python   rrdtool   software-properties-common   unzip   uuid-dev   wget   zlib1g-dev

# clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install R
# https://cran.r-project.org/bin/linux/ubuntu/README.html
RUN R_VERSION=cran40 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    echo "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -c | awk '{print $2}')-$R_VERSION/" | sudo tee -a /etc/apt/sources.list && \
    add-apt-repository ppa:c2d4u.team/c2d4u4.0+ && \
    apt-get update && apt-get install -yq --no-install-recommends \
        r-base \
        r-base-dev \
    && apt-get clean \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
    rm -rf /var/lib/apt/lists/*

# install RStudio
RUN RSTUDIO_PKG=rstudio-server-${rstudio_version}-amd64.deb && \
    cd /tmp && \
    wget -q https://download2.rstudio.org/server/bionic/amd64/${RSTUDIO_PKG} && \
    gdebi -n /tmp/${RSTUDIO_PKG} && \
    rm /tmp/${RSTUDIO_PKG}
ENV PATH="${PATH}:/usr/lib/rstudio-server/bin"
ENV LD_LIBRARY_PATH="/usr/lib/R/lib:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server"


# pip packages
RUN pip install --upgrade --no-cache \
      jupyter-rsession-proxy \ 
      rpy2

# Use this URL to work with the binary packages available 
# https://packagemanager.rstudio.com/client/#/repos/1/overview
RUN echo 'options(repos = c(REPO_NAME = "https://packagemanager.rstudio.com/all/__linux__/focal/latest"))' > ~/.Rprofile

## R packages
RUN Rscript -e 'install.packages(c("IRkernel", "Rmagic", "BiocManager", "devtools"), dependencies = TRUE)'
RUN Rscript -e 'IRkernel::installspec(prefix="/opt/conda")'
RUN Rscript -e 'BiocManager::install()'

# clean conda cache
RUN  mamba clean --index-cache --tarballs --yes

# fix permissions
RUN fix-permissions /opt/conda/share/jupyter/kernels/ && \
    fix-permissions /usr/lib/R/ && \
    fix-permissions /usr/local/lib/R/site-library

RUN R --version > /sanger/r.info && \
    Rscript -e "as.data.frame(installed.packages()[,c(1,3:4)])[,1:2,drop=FALSE]" > /sanger/r-packages.info && \
    conda list > /sanger/conda.info && \
    echo "$rstudio_version" > /sanger/rstudio.info && \
    echo "$image_name-$tag_name" >> /sanger/image.info

COPY poststart.sh /poststart/r-base.sh
