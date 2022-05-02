#!/bin/bash

pushd $(readlink -f $(dirname $0))
source ../../etc/env.sh

case ${STRIBO_MACHINE_ROLE} in
  single )
    info "This machine is: ${STRIBO_MACHINE_ROLE}. Using bind mount"
    MOUNT_VOLUME="  -v ${SINGLE_NFS_FRONT_END_PLAY_PATH}:/usr/share/nginx/html "
    ;;
  play | playfront )
    info "This machine is: ${STRIBO_MACHINE_ROLE}. Using NFS mount"
    MOUNT_VOLUME="   --mount source=${FRONT_END_PLAY_VOL_NAME},target=/usr/share/nginx/html "
    ;;
  *)
    pringred STRIBO_MACHINE_ROLE: ${STRIBO_MACHINE_ROLE}. Exit!
    popd
    exit 0;
    ;;
esac


docker run \
  --name ${FRONTEND_PLAY_CONTAINER_NAME} \
  --hostname ${FRONTEND_PLAY_CONTAINER_NAME} \
  --network=${NET_BACK_FRONT} \
   ${MOUNT_VOLUME} \
   --env BACKEND_PLAY_CONTAINER_NAME=${BACKEND_PLAY_CONTAINER_NAME} \
  -p 80:80 \
  -p 8080:8080 \
  -d -it\
  --restart unless-stopped \
  --log-opt max-size=10m --log-opt max-file=5 \
  ${FRONT_PLAY_INAGE}


popd
