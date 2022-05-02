#!/bin/bash

pushd $(readlink -f $(dirname $0))
source ../../etc/env.sh

case ${STRIBO_MACHINE_ROLE} in
  single )
    info "This machine is: ${STRIBO_MACHINE_ROLE}. Using bind mount"
    MOUNT_VOLUME="  -v ${SINGLE_DB_VOLUME_PATH}:/app "
    ;;
  play | playback | playfront | db )
    info "This machine is: ${STRIBO_MACHINE_ROLE}. Using NFS mount"
    MOUNT_VOLUME="   --mount source=${DB_VOLUME_NAME},target=/app "
    ;;
  *)
    pringred STRIBO_MACHINE_ROLE: ${STRIBO_MACHINE_ROLE}. Exit!
    popd
    exit 0;
    ;;
esac

#DO NOT FORGET!
apt-get  -y install nfs-common

isVolumeExists(){
  local volname=$1
  if [ "$(docker volume ls  --format "{{.Name}}" | grep $volname)" == "$volname" ] ; then 
    echo "yes"
  else 
    echo "no"
  fi
}



createNfsVolume(){
  local name=$1
  local path=$2

  if [ "$(isVolumeExists "${name}")" == "yes" ] ; then
    info "The volume  ${name} may be exists?"
  else
    docker volume create --driver local \
    --opt type=nfs \
    --opt o=addr=${NFS_VOLUME_SERVER},rw \
    --opt device=:/${path} \
    ${name}
    info "Create volume $name, $path"
  fi
}


createNfsVolume ${BACK_END_PLAY_VOL_NAME} ${NFS_BACK_END_PLAY_PATH}

createNfsVolume ${FRONT_END_PLAY_VOL_NAME} ${NFS_FRONT_END_PLAY_PATH}

createNfsVolume ${DB_VOLUME_NAME} ${NFS_DB_VOLUME_PATH}



    
popd    
