# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    
    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    config.vm.hostname = "dev.catshop.io"
    config.vm.box = "puppetlabs/centos-7.0-64-puppet"
    config.vm.network "private_network", ip: "192.168.51.101"

    config.vm.provision :shell do |shell|
        shell.inline = "mkdir -p /etc/puppet/modules;
                  puppet module install puppetlabs/postgresql;"
    end

    config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "vagrant/manifests"
      puppet.module_path = "vagrant/modules"
      puppet.manifest_file = "default.pp"
    end

end
