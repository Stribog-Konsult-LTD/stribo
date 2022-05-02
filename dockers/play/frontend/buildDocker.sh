#!/bin/bash

pushd $(readlink -f $(dirname $0))
source ../../etc/env.sh

docker build -t ${FRONT_PLAY_INAGE} .

popd
