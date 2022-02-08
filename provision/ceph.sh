#!/bin/bash

if [ "$(hostname -s)" == "server1" ]; then
	#dnf install -y cephadm
	wget --quiet https://github.com/ceph/ceph/raw/pacific/src/cephadm/cephadm -O /usr/bin/cephadm
	chmod +x /usr/bin/cephadm
fi
