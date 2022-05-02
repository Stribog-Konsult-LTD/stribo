#!/bin/bash

#Подготвя дебиан машината за работа. 

set -e
MAIN_FOLDER='/data/'
REPO_FOLDER='stribo/'
ROOT_OF_PROJECT="${MAIN_FOLDER}${REPO_FOLDER}"

printred(){
    RED='\033[06;33m'
    NC='\033[00m' # No Color
    echo -e "\n${RED}${@}${NC} \n"
}

printgreen(){
    GREEN='\033[06;32m'
    NC='\033[00m' # No Color
    echo -e  "\n${GREEN}${@}${NC} \n"
}

printgreen "Update system"
apt-get update 

printgreen "Remove man-db - това е за да не се бави ъпгрейда"
apt-get remove -y man-db --purge

printgreen "Упграде system"
apt-get upgrade -y

printgreen "autoremove"
apt-get autoremove -y

printgreen "Инсталирам git"
apt-get install -y git


printgreen "Инсталирам docker"
curl https://get.docker.com | sh

printgreen "Тествам docker"
docker run --name hello-world hello-world 
sleep 5
docker rm hello-world



reboot
