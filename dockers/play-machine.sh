#!/bin/bash





pushd $(dirname $(readlink -f $0))

sed -i "s/^NFS_VOLUME_SERVER=.*/s/^NFS_VOLUME_SERVER=192.168.2.188/g" ~/.bashrc  \


source etc/env.sh


export STRIBO_MACHINE_ROLE=play




./set-machine-role.sh play

set -e

# #
# # printgreen "Създавам дървото директории.
# # printgreen "Пускам NFS сървър, ако не сме на една машина
# # ./nfs-bld/nfs/run.sh
# #
# #
# # printgreen "Създавам контейнер с java за back end"
# # ./nfs-bld/backend/buildDocker.sh
# #
# # printgreen "Стартирам контейнер за Build Spring app"
# # ./nfs-bld/backend/run.sh
# #
# # printgreen "Компилирам Spring app"
# # docker exec -it back-build bash -c "cd /app ;  bash mvnw package "
# #
# # printgreen " Стартирам контейнер за Build Angular"
# # ./nfs-bld/frontend/run.sh
# #
# # printgreen "Компилирам Angular"
# # docker exec -it front-build bash -c "cd /app ; npm install ; npm run build "
# #

# Play

printgreen "Създавам Volumes, ако сме на повече от една машина и ни трябва NFS"
./play/volumes/create-volumes.sh

printgreen "Създавам две мрежи"
printgreen "Едната е за връзка между DB и back end,"
printgreen "а другата за back end - front end"
./play/network/create-networks.sh

printgreen "Стартирам DB"
./play/db/run.sh

printgreen "Създавам контейнер с java за back end"
./nfs-bld/backend/buildDocker.sh

printgreen "Създавам контейнер изпълнение на backend"
./play/backend/run.sh



printgreen " Създавам контейнер изпълнение на frontend"
./play/frontend/buildDocker.sh
./play/frontend/run.sh

printgreen " Стартирам  backend"
docker exec -it back-play bash -c " cd /app ; java -jar stribodemo-0.0.1-SNAPSHOT.jar "







