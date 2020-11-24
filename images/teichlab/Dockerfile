ARG tag_name
ARG parent_image="r-full"
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
RUN mamba env update --file /tmp/environment.yml

# R packages
RUN Rscript -e 'install.packages(c("vcfR","car","ggpubr","SoupX"));'
RUN Rscript -e 'devtools::install_github(c("velocyto-team/velocyto.R", "im3sanger/dndscv"))'

# clean conda cache
RUN  mamba clean --index-cache --tarballs --yes

# Fix permissions
RUN fix-permissions $CONDA_DIR && \
    fix-permissions /usr/lib/R/ && \
    fix-permissions /usr/local/lib/R/site-library

ENV TAG_NAME="teichlab-$tag_name"
RUN echo "$TAG_NAME" >> /sanger/image.info

