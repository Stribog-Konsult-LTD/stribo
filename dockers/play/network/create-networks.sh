#!/bin/bash

pushd $(readlink -f $(dirname $0))
source ../../etc/env.sh

isNetworkExists(){
  local netname=$1
  if [ "$(docker network ls  --format "{{.Name}}" | grep $netname)" == "$netname" ] ; then 
    echo "yes"
  else 
    echo "no"
  fi
}

createNetwork(){
    local net_name="$1"
    local subnet=$2
    local range=$3
    if [ "$(isNetworkExists "${net_name}")" == "yes" ] ; then
        info "The network ${net_name} may be exists?"
    else
        docker network create ${net_name} --subnet $subnet --ip-range  $range
    fi
}



createNetwork ${NET_DB_BACK_END}  ${SUBNET_DB_BACK_END} ${RANGE_DB_BACK_END}
createNetwork ${NET_BACK_FRONT} ${SUBNET_BACK_FRONTD} ${RANGE_BACK_FRONT}


popd
