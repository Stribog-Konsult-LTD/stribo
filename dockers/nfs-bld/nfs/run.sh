#!/bin/bash

pushd $(dirname $(readlink -f $0))
source ../../etc/env.sh


case ${STRIBO_MACHINE_ROLE} in
  nfs | nfsbuild )
    info "This machine is: ${STRIBO_MACHINE_ROLE}. Starting NFS server"
    ;;
  *)
    info STRIBO_MACHINE_ROLE: ${STRIBO_MACHINE_ROLE}
    popd
    exit 0;
    ;;
esac

modprobe nfs
modprobe nfsd

mkdir -p ${NFS_VOLUMEROOT}/mariadb
chown -R nobody:nogroup ${NFS_VOLUMEROOT}

docker run \
  --name ${NFS_CONTAINER_NAME}     \
  --hostname ${NFS_CONTAINER_NAME} \
  -v ${NFS_VOLUMEROOT}:/data               \
  -v $(pwd)/exports:/etc/exports   \
  -p 111:111     -p 111:111/udp     \
  -p 2049:2049   -p 2049:2049/udp   \
  -p 32765:32765 -p 32765:32765/udp \
  -p 32767:32767 -p 32767:32767/udp \
  --privileged                      \
   -d \
  --restart unless-stopped \
  --log-opt max-size=10m --log-opt max-file=5 \
  erichough/nfs-server

popd
