#!/bin/bash

mkdir -p /root/.ssh
cp /vagrant/files/id_rsa* /root/.ssh/
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chmod 400 /root/.ssh/id_rsa*

# Cria swap se não existir
if [ "$(swapon -v)" == "" ]; then
  dd if=/dev/zero of=/swapfile bs=1M count=512
  chmod 0600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile       swap    swap    defaults        0       0' >> /etc/fstab
fi

apt-get update && apt-get install -y gnupg apt-transport-https

wget -q -O- 'https://download.ceph.com/keys/release.asc' | apt-key add -
echo "deb https://download.ceph.com/debian-pacific/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/ceph.list

apt-get update && apt-get install -y podman lvm2 ceph-common
