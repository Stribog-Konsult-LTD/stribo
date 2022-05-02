#!/bin/bash -x

nginx
mkfifo /tmp/fifo
socat tcp-listen:8080,reuseaddr,fork tcp:back-play:8080



