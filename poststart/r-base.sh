#!/usr/bin/env bash

. /poststart/base.sh

# set package manager repo
# https://packagemanager.rstudio.com/client/#/repos/1/overview
if [[ -z "$(grep REPO_NAME /home/jovyan/.Rprofile 2>/dev/null)" ]]; then
  echo "options(repos = c(REPO_NAME = \"https://packagemanager.rstudio.com/all/__linux__/focal/latest\"))" >> /home/jovyan/.Rprofile
fi

# fix missing LC_ environment variables in RStudio
if [[ -z "$(grep LC_ALL /home/jovyan/.Renviron 2>/dev/null)" ]]; then
  echo "LC_ALL=en_US.UTF-8" >> /home/jovyan/.Renviron
fi

# install packages on home profile (/home/jovyan)
# allows persistance of packages across sessions
Rscript -e 'dir.create(path = Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)'
Rscript -e '.libPaths( c( Sys.getenv("R_LIBS_USER"), .libPaths() ) )'
