#!/bin/bash
set -e
docker-compose down
docker-compose rm -f -v
[[ -z $(docker ps -aq) ]] || docker rm $(docker ps -aq)
echo 'y' | docker volume prune
if [[ -z $(docker images mariadb:latest -q) ]]; then
    docker pull mariadb:10.3.9
    docker tag mariadb:10.3.9 mariadb:latest
fi
if [[ -z $(docker images itop:latest -q) ]]; then
    docker-compose build
fi
docker-compose up -d