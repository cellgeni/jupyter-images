ARG tag_name
ARG parent_image="r-full"
ARG registry="quay.io/cellgeni/jupyter"

FROM ${registry}:${parent_image}-${tag_name}

ARG tag_name
ARG image_name="py-r-full"

USER root

# general OS packages
RUN apt-get update -y -qq && \
    apt-get clean

# conda packages
COPY environment.yml /tmp/environment.yml
RUN mamba env update --file /tmp/environment.yml

# clean conda cache
RUN  mamba clean --index-cache --tarballs --yes

# fix permissions
RUN fix-permissions $CONDA_DIR

RUN echo "$image_name-$tag_name" > /sanger/image.info && \
    conda list > /sanger/conda.info

COPY poststart.sh /poststart/py-r-full.sh
