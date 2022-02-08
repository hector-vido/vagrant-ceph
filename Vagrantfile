# -*- mode: ruby -*-
# vi: set ft=ruby :

vms = {
  'server1' => {'memory' => 3072, 'cpus' => 2, 'ip' => '10', 'script' => 'ceph.sh'},
  'server2' => {'memory' => 3072, 'cpus' => 2, 'ip' => '20', 'script' => 'ceph.sh'},
  'server3' => {'memory' => 3072, 'cpus' => 2, 'ip' => '30', 'script' => 'ceph.sh'},
  'client'  => {'memory' =>  512, 'cpus' => 1, 'ip' => '40', 'script' => 'client.sh'}
}

Vagrant.configure('2') do |config|

  config.vm.box_check_update = false

  vms.each do |name, conf|
    config.vm.define "#{name}" do |my|
      my.vm.box = 'debian/bullseye64'
      my.vm.hostname = "#{name}.172-27-11-#{conf['ip']}.nip.io"
      my.vm.network 'private_network', ip: "172.27.11.#{conf['ip']}"
      my.vm.provision 'shell', path: "provision/#{conf['script']}"
      my.vm.provider 'virtualbox' do |vb|
        vb.memory = conf['memory'] || resources['memory']
        vb.cpus = conf['cpus'] || resources['cpus']
      end
      my.vm.provider 'libvirt' do |lv|
        lv.memory = conf['memory'] || resources['memory']
        lv.cpus = conf['cpus'] || resources['cpus']
        lv.cputopology :sockets => 1, :cores => conf['cpus'] || resources['cpus'], :threads => '1'
      end
    end
  end

  config.vm.provision 'shell', path: 'provision/provision.sh'

end
