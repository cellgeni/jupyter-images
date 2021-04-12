#!/usr/bin/env bash

# copy example notebooks only if there are more than 5GB left
if [[ "$(df -k /home/jovyan | awk 'NR>1 {print $4}')" -ge "5000000" ]]; then
    TMP_NOTEBOOKS=/tmp/example-notebooks.zip
    wget --quiet -O $TMP_NOTEBOOKS https://github.com/cellgeni/notebooks/archive/master.zip
    unzip $TMP_NOTEBOOKS -d /tmp
    cp -Rf /tmp/notebooks-master/notebooks /home/jovyan/
    cp -Rf /tmp/notebooks-master/data /home/jovyan/
    rm -rf $TMP_NOTEBOOKS /tmp/notebooks-master/
fi


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


# add conda init to ~/.profile script
if [[ -z "$(grep conda /home/jovyan/.profile 2>/dev/null)" ]]; then
cat >> /home/jovyan/.profile <<EOF
# !! Contents within this block are managed by 'conda init' !!
eval "\$('/opt/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# <<< conda initialize <<<
EOF
fi

#sudo chmod 644 /etc/ssh/ssh_config.d/keepalive.conf
#sudo chown jovyan /etc/ssh/ssh_config.d/keepalive.conf
sudo chmod 644 /etc/ssh/ssh_config.d/keepalive.conf

export USER=jovyan
