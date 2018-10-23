# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  # config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 9001, host: 9001
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"
  config.vm.synced_folder "./bootstrap", "/home/vagrant/bootstrap"
  config.vm.synced_folder "./workspace", "/home/vagrant/workspace"
  config.vm.define :itop do |itop|
    config.vm.hostname = "centos-itop"
  end
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
    vb.name = "itop"
    vb.cpus = 2
  end
  config.vm.provision "shell", inline: <<-SHELL
    cd /home/vagrant/bootstrap && /bin/bash prereqs.sh vagrant
  SHELL
end
