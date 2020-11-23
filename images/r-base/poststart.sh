#!/usr/bin/env bash

/poststart/base.sh

# set package manager repo
# https://packagemanager.rstudio.com/client/#/repos/1/overview
cat > /home/jovyan/.Rprofile <<EOF
options(repos = c(REPO_NAME = "https://packagemanager.rstudio.com/all/__linux__/focal/latest"))
EOF

# install packages on home profile (/home/jovyan)
# allows persistance of packages across sessions
Rscript -e 'dir.create(path = Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)'
Rscript -e '.libPaths( c( Sys.getenv("R_LIBS_USER"), .libPaths() ) )'
