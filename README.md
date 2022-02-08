# Ceph

```bash
for X in 1 2 3; do 
	qemu-img create -f qcow2 /var/lib/libvirt/images/server$X-osd.qcow2 10G
	virsh attach-disk vagrant-ceph_server$X /var/lib/libvirt/images/server$X-osd.qcow2 vdb --driver qemu --subdriver qcow2 --persistent
done
```

```bash
ceph config set mon auth_allow_insecure_global_id_reclaim false
ceph mon enable-msgr2
```

```yaml
service_type: host
addr: 172.27.11.10
hostname: server1
---
service_type: host
addr: 172.27.11.20
hostname: server2
---
service_type: host
addr: 172.27.11.30
hostname: server3
---
service_type: host
addr: 172.27.11.40
hostname: client
---
service_type: mon
placement:
  hosts:
  - server1
  - server2
  - server3
---
service_type: osd
service_id: default
placement:
  host_pattern: 'server*'
data_devices:
  all: true
```

```bash
cephadm bootstrap --apply-spec bootstrap.yml --mon-ip 172.27.11.10 --initial-dashboard-password=redhat --dashboard-password-noupdate
```
