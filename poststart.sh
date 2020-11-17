#!/usr/bin/env bash

# copy example notebooks
TMP_NOTEBOOKS=/tmp/example-notebooks.zip
wget --quiet -O $TMP_NOTEBOOKS https://github.com/cellgeni/notebooks/archive/master.zip 
unzip $TMP_NOTEBOOKS -d /tmp
rm /tmp/notebooks-master/.gitignore /tmp/notebooks-master/LICENSE /tmp/notebooks-master/README.md
cp -Rf /tmp/notebooks-master/. .
rm -rf $TMP_NOTEBOOKS /tmp/notebooks-master/


# copy default run commands but provide a way for users to keep their own config
if [ ! -f .keep-local-conf ]; then
    # .condarc: set env_prompt, channels, envs_dirs,create_default_packages
    cp /config/.condarc /home/jovyan/
    # .Rprofile: set binary package repo
    cp /config/.Rprofile /home/jovyan/
fi


# .bashrc: activate myenv by default
if [ ! -f .bashrc ]; then
    echo 'source activate myenv' > .bashrc
else
    grep -qF 'source activate myenv' .bashrc || echo 'source activate myenv' >> .bashrc
fi


# .bash_profile: make login shells source .bashrc
if [ ! -f .bash_profile ]; then
    echo "source ~/.bashrc" > .bash_profile
else
    grep -qF 'source ~/.bashrc' .bash_profile || echo 'source ~/.bashrc' >> .bash_profile
fi


# create default environment 'myenv'
if [ ! -d my-conda-envs/myenv ]; then
    conda create --clone base --name myenv
    source activate myenv
fi


Rscript -e 'dir.create(path = Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)'
Rscript -e '.libPaths( c( Sys.getenv("R_LIBS_USER"), .libPaths() ) )'
Rscript -e 'IRkernel::installspec()'


# create matching folders to mount the farm
if [ ! -d /nfs ] || [ ! -d /lustre ] || [ ! -d /warehouse ]; then
    sudo mkdir -p /nfs
    sudo mkdir -p /lustre
    sudo mkdir -p /warehouse
fi


# set env vars for nbresuse limits
export MEM_LIMIT=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
CPU_NANOLIMIT=$(cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us)
export CPU_LIMIT=$(($CPU_NANOLIMIT/100000))

export USER=jovyan
