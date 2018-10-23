#!/bin/bash
sudo yum update -y
set -e
sudo yum makecache fast
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
# sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo cp $(pwd)/docker-ce.repo /etc/yum.repos.d/docker-ce.repo
sudo sed -i 's+download.docker.com+mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo
yum list docker-ce --showduplicates | sort -r
sudo yum install docker-ce -y
sudo usermod -aG docker ${1:-$(whoami)}
sudo systemctl start docker
sudo systemctl enable docker
sudo yum install python2-pip -y
sudo pip install docker-compose -i https://pypi.tuna.tsinghua.edu.cn/simple
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