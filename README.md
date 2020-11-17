# Cellular Genetics Informatics JupyterHub Docker Image

[![Docker Repository on Quay](https://quay.io/repository/cellgeni/cellgeni-jupyter/status "Docker Repository on Quay")](https://quay.io/repository/cellgeni/cellgeni-jupyter)

We support a Jupyter Hub server running on Sanger Cloud. Jupyter allows you to run your analysis in multiple environments (R, python, Julia, etc.) and also to create and share notebooks containing your analysis, code, equations and visualizations. We think this is an ideal environment for any kind of downstream analysis. For more details please refer to Jupyter Hub documentation.

### Image hierarchy diagram
```
                    +------+
                    | base |
                    +------+
                        +
                        |
      +-----------------+------------------+
      |                 |                  | 
      V                 V                  V
  +-------+         +--------+         +--------+
  | julia |         | python |         | r-base |
  +-------+         +--------+         +--------+
                        +                  +
                        |                  |
                        V                  V
                   +-----------+       +--------+
                   | py-r-full | <---+ | r-full |
                   +-----------+       +--------+
                                           +
                                           |
                                           V
                                      +----------+
                                      | teichlab |
                                      +----------+
```


## Image content

  - [base](#base) base image, contains the minimum to launch notebooks
  - [python](#python) python image, contains most popular packages for python
  - [julia](#julia) julia image, contains most popular julia packages for julia
  - [r-base](#r-base) R base image, contains R language kernel and R Studio with minimum packages
  - [r-full](#r-full) R full image, contains most popular R packages for R
  - [py-r-full](#py-r-full) Python and R full image, contains most popular packages for both Python and R.
  - [teichlab](#teichlab) custom image containing the Teichmann lab requirments

### base

- Operating system: Ubuntu focal 20.04.1 LTS
- Additional packages:
  - rclone v1.53.2
  - go v1.15.3
  - singularity v3.6.1
- Python v3.8.6

### python

- Operating system: Ubuntu focal 20.04.1 LTS
- Additional packages:
  - rclone v1.53.2
  - go v1.15.3
  - singularity v3.6.1
- Python v3.8.6
- Python packages:
  - cython
  - cmake
  - numpy
  - python-igraph
  - pandas
  - louvain
  - leidenalg
  - scanpy
  - scikit-learn
  - matplotlib
  - seaborn
  - sccaf
  - plotly
  - scvi-tools
  - bbknn
  - h5py
  - scvelo
  - scirpy
  - palantir
  - velocyto
  - pyscenic

### julia
- Operating system: Ubuntu focal 20.04.1 LTS
- Additional packages:
  - rclone v1.53.2
  - go v1.15.3
  - singularity v3.6.1
- Python v3.8.6
- Julia v1.5.2
- Julia packages:
  - IJulia
  - CSV
  - Gadfly
  - RDatasets
  - Distances
  - StatsBase
  - Hadamard
  - HDF5
  - JLD
  - StatsBase
  - Statistics
  - Embeddings
  - DataFrames
  - GLM
  - LsqFit
  - Combinatorics
  - Cairo

### r-base
- Additional packages:
  - rclone v1.53.2
  - go v1.15.3
  - singularity v3.6.1
- Python v3.8.6
- Python packages:
  - rpy2
- R version 4.0.3 (2020-10-10) -- "Bunny-Wunnies Freak Out"
- RStudio version 1.2.5019
- R packages:
  - IRkernel
  - Rmagic
  - BiocManager
  - devtools

### r-full
- Operating system: Ubuntu focal 20.04.1 LTS
- Additional packages:
  - rclone v1.53.2
  - go v1.15.3
  - singularity v3.6.1
- Python v3.8.6
- Python packages:
  - rpy2
- R version 4.0.3 (2020-10-10) -- "Bunny-Wunnies Freak Out"
- RStudio version 1.2.5019
- R packages:
  - IRkernel
  - Rmagic
  - BiocManager
  - devtools
  - tidyverse
  - rJava
  - umap
  - ggplot2
  - ggfortify
  - igraph
  - lsa
  - uwot
  - optparse
  - Seurat
  - SummarizedExperiment
  - SingleCellExperiment
  - DropletUtils
  - LoomExperiment
  - Rhdf5lib
  - scater
  - scran
  - RUVSeq
  - sva
  - MultiAssayExperiment
  - batchelor
  - edgeR
  - DESeq2
  - BiocParallel
  - SC3
  - destiny
  - pcaMethods
  - zinbwave
  - GenomicAlignments
  - M3Drop
  - switchde
  - biomaRt
  - Matrix.utils
  - cellgeni/sceasy
  - mojaveazure/loomR
  - immunogenomics/harmony
  - cole-trapnell-lab/leidenbase
  - cole-trapnell-lab/monocle3

### py-r-full
- Operating system: Ubuntu focal 20.04.1 LTS
- Additional packages:
  - rclone v1.53.2
  - go v1.15.3
  - singularity v3.6.1
  - samtools
  - bcftools
  - bedtools
  - parallel
- Python v3.8.6
- Python packages:
  - cython
  - cmake
  - numpy
  - python-igraph
  - pandas
  - louvain
  - leidenalg
  - scanpy
  - scikit-learn
  - matplotlib
  - seaborn
  - sccaf
  - plotly
  - scvi-tools
  - bbknn
  - h5py
  - scvelo
  - scirpy
  - palantir
  - velocyto
  - pyscenic
  - rpy2
- R version 4.0.3 (2020-10-10) -- "Bunny-Wunnies Freak Out"
- RStudio version 1.2.5019
- R packages:
  - IRkernel
  - Rmagic
  - BiocManager
  - devtools
  - tidyverse
  - rJava
  - umap
  - ggplot2
  - ggfortify
  - igraph
  - lsa
  - uwot
  - optparse
  - Seurat
  - SummarizedExperiment
  - SingleCellExperiment
  - DropletUtils
  - LoomExperiment
  - Rhdf5lib
  - scater
  - scran
  - RUVSeq
  - sva
  - MultiAssayExperiment
  - batchelor
  - edgeR
  - DESeq2
  - BiocParallel
  - SC3
  - destiny
  - pcaMethods
  - zinbwave
  - GenomicAlignments
  - M3Drop
  - switchde
  - biomaRt
  - Matrix.utils
  - cellgeni/sceasy
  - mojaveazure/loomR
  - immunogenomics/harmony
  - cole-trapnell-lab/leidenbase
  - cole-trapnell-lab/monocle3


### teichlab
- Operating system: Ubuntu focal 20.04.1 LTS
- Additional packages:
  - rclone v1.53.2
  - go v1.15.3
  - singularity v3.6.1
- Python v3.8.6
- Python packages:
  - numpy
  - cython
  - python-igraph
  - pandas
  - louvain
  - leidenalg
  - gpy  
  - scanpy
  - scikit-learn
  - matplotlib
  - snakemake
  - cmake
  - sccaf
  - pytest
  - plotly
  - ggplot
  - scvi-tools
  - bbknn
  - h5py
  - velocyto
  - spatialde
  - scvelo
  - wot
  - cellphonedb
  - pyscenic
  - scirpy
  - palantir
  - rpy2
- R version 4.0.3 (2020-10-10) -- "Bunny-Wunnies Freak Out"
- RStudio version 1.2.5019
- R packages:
  - IRkernel
  - Rmagic
  - BiocManager
  - devtools
  - tidyverse
  - rJava
  - umap
  - ggplot2
  - ggfortify
  - igraph
  - lsa
  - uwot
  - optparse
  - Seurat
  - SummarizedExperiment
  - SingleCellExperiment
  - DropletUtils
  - LoomExperiment
  - Rhdf5lib
  - scater
  - scran
  - RUVSeq
  - sva
  - MultiAssayExperiment
  - batchelor
  - edgeR
  - DESeq2
  - BiocParallel
  - SC3
  - destiny
  - pcaMethods
  - zinbwave
  - GenomicAlignments
  - M3Drop
  - switchde
  - biomaRt
  - Matrix.utils
  - cellgeni/sceasy
  - mojaveazure/loomR
  - immunogenomics/harmony
  - cole-trapnell-lab/leidenbase
  - cole-trapnell-lab/monocle3
  - vcfR
  - car
  - ggpubr
  - SoupX
  - velocyto-team/velocyto.R
  - im3sanger/dndscv

### Build order
1. [base](images/base/)
2. [julia](images/julia/)
3. [python](images/python/)
4. [r-base](images/r-base/)
5. [r-full](images/r-full/)
6. [py-r-full](images/py-r-full/)
7. [teichlab](images/teichlab/)

Order is taken from [images/build_list.txt](images/build_list.txt)

### Build images
Each image is build using a `TAG` argument.
```bash
docker build --build-arg tag_name=$TAG --tag "$REGISTRY:$IMAGE-$TAG" .
```

All images can be build at the same time by runnning
`images/build_all`

## Developer instructions

These are  docker images for Cellular Genetics Informatics JupyterHub installation that are based on [docker-stacks](https://github.com/jupyter/docker-stacks) and used with [Zero to JupyterHub with Kubernetes](https://zero-to-jupyterhub.readthedocs.io/en/latest/) for scientific analysis.

_:warning: images contain `poststart` scripts that run when the instance is launched and may override default files such as `.condarc` and `.Rprofile` from the home directory._


### Updating JupyterHub on k8s

1. Clone the private repository with [Cellgeni JupyterHub settings](https://gitlab.internal.sanger.ac.uk/cellgeni/kubespray/):
```
git clone  https://gitlab.internal.sanger.ac.uk/cellgeni/kubespray/
cd kubespray/sanger/sites
```
2. Add the new user's Github username to `auth.whitelist.users` or change Docker image at `singleuser.image.tag` in `jupyter-large-config.yaml`.

3. Commit and push your changes so that your colleagues do not override your changes in the following upgrades
```
git add jupyter-large-config.yaml && git commit -m "Add new users" && git push
```
3. Upgrade Jupyter with  
```
helm upgrade jptl jupyterhub/jupyterhub --namespace jptl --version 0.8.0 --values jupyter-large-config.yaml
```
4. Wait until the hub's state switches into `Running`. Monitor through `kubectl get pods -n jptl`.

## User instructions

1. In your browser go to [https://jupyter.cellgeni.sanger.ac.uk](https://jupyter.cellgeni.sanger.ac.uk).
2. Use your Github credentials for authentication. It may take some time to load first time.
3. Now you are ready to run your notebooks!

**[Read the docs for Cellgeni JupyterHub](https://cellgeni.readthedocs.io/en/latest/jupyterhub.html)**

### Resources

At the moment by default every user is given 50GB (guaranteed) to 200GB (maximum, if available) of RAM and 1 (guaranteed) to 16 (maximum, if available) CPUs. Default storage volume is 100G.

### Important notes

- **JupyterHub environment and storage are not backed up**
- **Keep your notebooks light**. Notebooks over 100MB will give you unexpected errors.

