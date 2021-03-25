ARG tag_name
ARG parent_image="full"
ARG registry="quay.io/cellgeni/jupyter"

FROM $registry:$parent_image-$tag_name

USER root

# general OS packages
RUN apt-get update -y -qq && \
    apt-get install -y -qq \
      samtools bcftools bedtools parallel 

# clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# conda packages
COPY environment.yml /tmp/environment.yml
RUN mamba create --name teichlab --clone base && \
    mamba env update --name teichlab --file=/tmp/environment.yml && \
    /bin/bash -c "source activate teichlab && python -m ipykernel install --prefix=/opt/conda/envs/teichlab/ --name=teichlab"

# R packages
RUN Rscript -e 'install.packages(c("vcfR","car","ggpubr","SoupX"));'
RUN Rscript -e 'devtools::install_github(c("velocyto-team/velocyto.R", "im3sanger/dndscv"))'

# clean conda cache
RUN  mamba clean --index-cache --tarballs --yes

# Fix permissions
RUN fix-permissions $CONDA_DIR && \
    fix-permissions /usr/lib/R/ && \
    fix-permissions /usr/local/lib/R/site-library

RUN echo "$image_name=$tag_name" >> /sanger/image.info && \ 
    conda list > /sanger/conda.info && \
    Rscript -e "as.data.frame(installed.packages()[,c(1,3:4)])[,1:2,drop=FALSE]" > /sanger/r-packages.info

