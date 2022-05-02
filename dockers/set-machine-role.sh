#!/bin/bash

usage(){
    echo "It will set machine role (STRIBO_MACHINE_ROLE) in ~/.bashrc "
    echo " usage $0 < single | nfs | build |nfsbuild | play | playfront | playback | db > "
}


if [ $# -lt 1 ] ; then
  usage
  exit 1
fi

grep "^STRIBO_MACHINE_ROLE=" ~/.bashrc \
    && \
        sed -i "s/^export STRIBO_MACHINE_ROLE=.*/export STRIBO_MACHINE_ROLE=${1}/g" ~/.bashrc  \
    || \
        echo "export STRIBO_MACHINE_ROLE=${1}" >> ~/.bashrc
