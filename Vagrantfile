# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # needed for NGINX config !!!
  config.vm.synced_folder "./", "/vagrant_data"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # general all purpose provisioning
  config.vm.provision "shell", path: "scripts/bootstrap.sh"

  config.vm.provider "libvirt" do |lv|
    lv.cpus = 2
    lv.memory = 1024
  end
  
  # FOLDERNAME + "_" + NAME = QEMU_KVM_MACHINENAME
  name = "myvm"
  hostname = "myalpine"
  # alpine version picked from box store
  alpine = "alpine310"

  config.vm.define name do |machine|
    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://vagrantcloud.com/search.
    machine.vm.box = "generic/#{alpine}"
    # hostname tied to static IP in bridged public network
    machine.vm.hostname = hostname
    # bridged public network with static IP and MAC
    # --> you should put name/MAC/ip into fritz.box to make it visible within network
    machine.vm.network "public_network",
      adapter: 1,
      dev: "br0",
      mode: "bridge",
      type: "bridge",
      mac: "00:50:56:00:00:FF",
      ip: "192.168.178.128",
      hostname: true
    # replacing default loopback hostname (alpineXYZ) with proper hostname
    machine.vm.provision "shell", inline: <<-SHELL
      cp /etc/hosts /etc/hosts.bak && sed 's/#{alpine}/#{hostname}/g' /etc/hosts.bak > /etc/hosts
    SHELL
    #machine.vm.provision "shell", path: "scripts/nginx_provision.sh"
    machine.vm.provision "shell", path: "scripts/docker_provision.sh"
  end
  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
