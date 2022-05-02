#!/bin/bash

pushd $(readlink -f $(dirname $0))
source ../../etc/env.sh


case ${STRIBO_MACHINE_ROLE} in
  single )
    info "This machine is: ${STRIBO_MACHINE_ROLE}. Using bind mount"
    MOUNT_VOLUME="  -v ${SINGLE_BACK_END_PLAY_PATH}:/app "
    ;;
  play | playback )
    info "This machine is: ${STRIBO_MACHINE_ROLE}. Using NFS mount"
    MOUNT_VOLUME="   --mount source=${BACK_END_PLAY_VOL_NAME},target=/app "
    ;;
  *)
    printred STRIBO_MACHINE_ROLE: ${STRIBO_MACHINE_ROLE}. Exit!
    popd
    exit 0;
    ;;
esac



docker run \
  --name ${BACKEND_PLAY_CONTAINER_NAME} \
  --hostname ${BACKEND_PLAY_CONTAINER_NAME} \
  --network=${NET_DB_BACK_END} \
    ${MOUNT_VOLUME} \
  `#-p 8080:8080` \
  -it -d\
  --restart unless-stopped \
  --log-opt max-size=10m --log-opt max-file=5 \
  ${BACKEND_IMAGE}

  docker network connect ${NET_BACK_FRONT}  ${BACKEND_PLAY_CONTAINER_NAME}
#docker exec -it back-play bash -c " cd /app ; java -jar stribodemo-0.0.1-SNAPSHOT.jar "

popd
