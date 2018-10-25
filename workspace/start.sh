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
# 连接宿主机数据库
# export LOCAL_HOST=$(/sbin/ip route|awk '/default/ {print  $3}')
# export LOCAL_HOST=$(ifconfig docker0 | egrep "inet ([0-9]{1,3}.){3}[0-9]" | awk '{print $2}')
docker-compose up -d