#!/bin/bash

pushd $(readlink -f $(dirname $0))
source ../../etc/env.sh

docker build -t ${BACKEND_IMAGE} .

popd
