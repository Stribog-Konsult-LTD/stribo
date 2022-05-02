#!/bin/bash

pushd $(readlink -f $(dirname $0))
source ../../etc/env.sh

docker run \
    --name ${FRONTEND_BUILD_CONTAINER_NAME} \
    --hostname ${FRONTEND_BUILD_CONTAINER_NAME} \
     -v ${FRONT_END_BUILD_PATH}:/app \
    -it -d\
    node bash -c " cd /app ; echo '
    alias l=\"ls -plah --color=auto\"
    npm install
    npm run build
    npm install -g @angular/cli
    ng serve
    ' ; bash
    "
# docker exec -it front-build bash -c "cd /app ; npm install ; npm run build "

    
popd


