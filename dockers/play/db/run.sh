#!/bin/bash

pushd $(readlink -f $(dirname $0))
source ../../etc/env.sh


case ${STRIBO_MACHINE_ROLE} in
  single )
    info "This machine is: ${STRIBO_MACHINE_ROLE}. Using bind mount"
    MOUNT_VOLUME="  -v ${SINGLE_DB_VOLUME_PATH}:/app "
    ;;
  play | db )
    info "This machine is: ${STRIBO_MACHINE_ROLE}. Using NFS mount"
    MOUNT_VOLUME="   --mount source=${DB_VOLUME_NAME},target=/app "
    ;;
  *)
    pringred STRIBO_MACHINE_ROLE: ${STRIBO_MACHINE_ROLE}. Exit!
    popd
    exit 0;
    ;;
esac

runMaria(){
  docker run \
    --detach \
    --name ${DB_CONTAINER_NAME}  \
    --hostname ${DB_CONTAINER_NAME}  \
    --network=${NET_DB_BACK_END} \
    ${MOUNT_VOLUME} \
    -p 3306:3306 `# optional` \
    --env MARIADB_USER=${MARIADB_USER} \
    --env MARIADB_PASSWORD=${MARIADB_PASSWORD} \
    --env MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD}  \
    --env MARIADB_DATABASE=${MARIADB_DATABASE} \
    --env MYSQL_DATABASE=${MYSQL_DATABASE} \
    ${MARIA_DB_IMAGE}
}

docker ps --format "{{.Names}}" | grep ${DB_CONTAINER_NAME} || docker start ${DB_CONTAINER_NAME}  || runMaria

for i in `seq 1 200`;   do
    docker logs ${DB_CONTAINER_NAME} 2>&1 | grep "3306  mariadb.org binary distribution"
    [ "$?" -eq 0 ] && break;
    echo "MySql container is steel not ready! Try $i / 200 Please wait..."
    sleep 2
done
  
  
docker exec -i mariadb sh -c 'exec mysql -uroot -p"${MARIADB_ROOT_PASSWORD}"' < DB.sql 

popd
