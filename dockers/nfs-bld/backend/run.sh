#!/bin/bash

pushd $(readlink -f $(dirname $0))
source ../../etc/env.sh

docker run \
  --name ${BACKEND_BUILD_CONTAINER_NAME} \
  --hostname ${BACKEND_BUILD_CONTAINER_NAME} \
  -v ${BACK_END_BUILD_PATH}:/app \
  -it -d \
  --restart unless-stopped \
  --log-opt max-size=10m --log-opt max-file=5 \
  ${BACKEND_IMAGE} bash

#docker exec -it back-build bash -c "cd /app ;  bash mvnw package "


popd
