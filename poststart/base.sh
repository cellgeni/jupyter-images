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

# get irods-icommands singularity image
mkdir -p /home/jovyan/.irods/
wget -O /home/jovyan/.irods/irods.sif https://cellgeni.cog.sanger.ac.uk/singularity/images/irods.sif

# set env vars for nbresuse limits
#export MEM_LIMIT=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
CPU_NANOLIMIT=$(cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us)
export CPU_LIMIT=$(($CPU_NANOLIMIT/100000))

export USER=jovyan
