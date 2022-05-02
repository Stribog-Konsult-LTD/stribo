

ROOT_OF_PROJECT=$( readlink -f $( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/../../ )
NFS_VOLUME_SERVER='192.168.2.188'


# Networks
# Back-end and db will use NET_DB_BACK_END
# Back-end and front-end NET_BACK_FRONT
# front-end will no access to db

NET_DB_BACK_END='stribo_net_db_back'
SUBNET_DB_BACK_END='172.20.0.0/16'
RANGE_DB_BACK_END='172.20.240.0/20'

NET_BACK_FRONT='stribo_net_back_front'
SUBNET_BACK_FRONTD="172.21.0.0/16"
RANGE_BACK_FRONT="172.21.240.0/20"



# DB

MARIADB_USER=stribodemo
MARIADB_PASSWORD=stribodemo
MARIADB_ROOT_PASSWORD=my-secret-pw
MARIADB_DATABASE=stribodemo
MYSQL_DATABASE=stribodemo


# Build Volumes

# NFS_VOLUMEROOT bind volume, mounted to nfs container
NFS_VOLUMEROOT="${ROOT_OF_PROJECT}/stribo-demo/"
# SINGLE_VOLUMES_DIR bind volume, mounted when using single machine
SINGLE_VOLUMES_DIR="${ROOT_OF_PROJECT}/stribo-demo/"

# We build always binded volumes
BACK_END_BUILD_PATH="${SINGLE_VOLUMES_DIR}/back-end"
FRONT_END_BUILD_PATH="${SINGLE_VOLUMES_DIR}/front-end"


# NFS_VOLUMES_DIR - mount -t nfs UNF_IP:/${NFS_VOLUMES_DIR}
NFS_VOLUMES_DIR="/data/"


BACK_END_PLAY_VOL_NAME="vol_back_play"
NFS_BACK_END_PLAY_PATH="${NFS_VOLUMES_DIR}/back-end"
SINGLE_BACK_END_PLAY_PATH="${SINGLE_VOLUMES_DIR}/back-end/target"

FRONT_END_PLAY_VOL_NAME="vol_front_play"
NFS_FRONT_END_PLAY_PATH="${NFS_VOLUMES_DIR}/front-end/dist/front-end/"
SINGLE_NFS_FRONT_END_PLAY_PATH="${SINGLE_VOLUMES_DIR}/front-end/dist/front-end/"

DB_VOLUME_NAME=vol_mariadb
NFS_DB_VOLUME_PATH=${NFS_VOLUMES_DIR}/mariadb
SINGLE_DB_VOLUME_PATH=${SINGLE_VOLUMES_DIR}/mariadb


# Containers

NFS_CONTAINER_NAME='nfs'
DB_CONTAINER_NAME=mariadb
BACKEND_BUILD_CONTAINER_NAME='back-build'
BACKEND_PLAY_CONTAINER_NAME='back-play'
FRONTEND_BUILD_CONTAINER_NAME='front-build'
FRONTEND_PLAY_CONTAINER_NAME='front-play'

# Images
MARIA_DB_IMAGE='mariadb:latest'
BACKEND_IMAGE='debian_jdk_maven'
FRONT_PLAY_INAGE='nginx_proxy'


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

printblue(){
    GREEN='\033[01;34m'
    NC='\033[00m' # No Color
    echo -e  "\n${GREEN}${@}${NC} \n"
}

# INFO_DEVICE can be set to /dev/null to supress debug messages
INFO_DEVICE=/dev/stderr
info(){
    printblue $@ >> $INFO_DEVICE
}





