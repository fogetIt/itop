#!/bin/bash
yum update -y
set -e
yum makecache fast
yum install -y yum-utils device-mapper-persistent-data lvm2
# yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
cp $(pwd)/docker-ce.repo /etc/yum.repos.d/docker-ce.repo
sed -i 's+download.docker.com+mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo
yum list docker-ce --showduplicates | sort -r
yum install docker-ce -y
usermod -aG docker ${1:-$(whoami)}
systemctl start docker
systemctl enable docker
yum install python2-pip -y
pip install docker-compose -i https://pypi.tuna.tsinghua.edu.cn/simple
echo ''
echo 'Installation completed, versions installed are:'
echo ''
echo -n 'Docker:         '
docker --version
echo -n 'Python:         '
python -V
echo -n 'Docker Compose: '
docker-compose --version
echo ''
echo "Please logout then login before continuing."