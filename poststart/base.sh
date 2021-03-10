#!/usr/bin/env bash

# copy example notebooks
TMP_NOTEBOOKS=/tmp/example-notebooks.zip
wget --quiet -O $TMP_NOTEBOOKS https://github.com/cellgeni/notebooks/archive/master.zip 
unzip $TMP_NOTEBOOKS -d /tmp
rm /tmp/notebooks-master/.gitignore /tmp/notebooks-master/LICENSE /tmp/notebooks-master/README.md
cp -Rf /tmp/notebooks-master/. /home/jovyan/
rm -rf $TMP_NOTEBOOKS /tmp/notebooks-master/

#conda config file
cat > /home/jovyan/.condarc <<EOF
env_prompt: ({name})
channels:
  - conda-forge
  - bioconda
envs_dirs:
  - /home/jovyan/my-conda-envs/
create_default_packages:
  - pip
  - ipykernel
EOF

# create matching folders to mount the farm
if [ ! -d /nfs ] || [ ! -d /lustre ] || [ ! -d /warehouse ]; then
    sudo mkdir -p /nfs
    sudo mkdir -p /lustre
    sudo mkdir -p /warehouse
fi

# create irods path
mkdir -p /home/jovyan/.irods/
# wget -O /home/jovyan/.irods/irods.sif https://cellgeni.cog.sanger.ac.uk/singularity/images/irods.sif


# add conda init to ~/.profile script
if [[ -z "$(grep conda /home/jovyan/.profile 2>/dev/null)" ]]; then
cat >> /home/jovyan/.profile <<EOF
# !! Contents within this block are managed by 'conda init' !!
eval "\$('/opt/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# <<< conda initialize <<<
EOF
fi


export USER=jovyan
