ARG tag_name
ARG parent_image="r-full"
ARG registry="quay.io/cellgeni/jupyter"

FROM ${registry}:${parent_image}-${tag_name}

ARG tag_name
ARG image_name="full"
ARG julia_version="1.5.0"

USER root

# general OS packages
RUN apt-get update -y -qq && \
    apt-get clean

# conda packages
COPY environment.yml /tmp/environment.yml
RUN mamba env update --name base --file /tmp/environment.yml

# install Julia packages in /opt/julia instead of $HOME
ENV JULIA_DEPOT_PATH=/opt/julia \
    JULIA_PKGDIR=/opt/julia \
    JULIA_VERSION="${julia_version}"

RUN mkdir "/opt/julia-${JULIA_VERSION}" && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/$(echo "${JULIA_VERSION}" | cut -d. -f 1,2)"/julia-${JULIA_VERSION}-linux-x86_64.tar.gz" && \
    tar xzf "julia-${JULIA_VERSION}-linux-x86_64.tar.gz" -C "/opt/julia-${JULIA_VERSION}" --strip-components=1 && \
    rm "/tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz"
RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

# show Julia where conda libraries are \
RUN mkdir /etc/julia && \
    echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /etc/julia/juliarc.jl && \
    # Create JULIA_PKGDIR \
    mkdir "${JULIA_PKGDIR}" && \
    chown "${NB_USER}" "${JULIA_PKGDIR}" && \
    fix-permissions "${JULIA_PKGDIR}"

COPY install.jl /tmp/install.jl
RUN julia -e "include(\"/tmp/install.jl\");"


# move kernelspec out of home to the system share location \
RUN mv "${HOME}/.local/share/jupyter/kernels/julia"* "${CONDA_DIR}/share/jupyter/kernels/" && \
    chmod -R go+rx "${CONDA_DIR}/share/jupyter" && \
    rm -rf "${HOME}/.local" && \
    fix-permissions "${JULIA_PKGDIR}" "${CONDA_DIR}/share/jupyter"

# clean conda cache
RUN  mamba clean --index-cache --tarballs --yes

# fix permissions
RUN fix-permissions $CONDA_DIR

RUN echo "$image_name-$tag_name" > /sanger/image.info && \
    julia --version > /sanger/julia.info && \
    conda list > /sanger/conda.info
