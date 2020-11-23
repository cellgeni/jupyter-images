ARG tag_name
ARG parent_image="r-base"
ARG registry="quay.io/cellgeni/jupyter"

FROM ${registry}:${parent_image}-${tag_name}

ARG tag_name
ARG image_name="r-full"

USER root

# general OS packages
RUN apt-get update -y -qq 

# clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## R packages
RUN Rscript -e 'install.packages(c("tidyverse", "rJava", "umap", "ggplot2", "ggfortify", "igraph","devtools", "Rmagic", "lsa", "uwot", "optparse", "Seurat"), dependencies = TRUE)'

RUN Rscript -e 'BiocManager::install(c("SummarizedExperiment", "SingleCellExperiment", "DropletUtils", "LoomExperiment", "Rhdf5lib", "scater", "scran", "RUVSeq", "sva", "MultiAssayExperiment", "batchelor", "edgeR", "DESeq2", "BiocParallel", "SC3", "destiny", "pcaMethods", "zinbwave", "GenomicAlignments", "M3Drop", "switchde", "biomaRt", "Matrix.utils"));'

RUN Rscript -e 'devtools::install_github(c("cellgeni/sceasy", "mojaveazure/loomR", "immunogenomics/harmony", "cole-trapnell-lab/leidenbase", "cole-trapnell-lab/monocle3"));'

# clean conda cache
RUN  mamba clean --index-cache --tarballs --yes

# fix permissions
RUN fix-permissions /usr/lib/R/ && \
    fix-permissions /usr/local/lib/R/site-library

RUN echo "$image_name=$tag_name" >> /sanger/image.info && \ 
    conda list > /sanger/conda.info && \
    Rscript -e "as.data.frame(installed.packages()[,c(1,3:4)])[,1:2,drop=FALSE]" > /sanger/r-packages.info


COPY poststart.sh /poststart/r-full.sh
RUN chmod +x /poststart/*.sh

