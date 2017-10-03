# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  config.vm.network "private_network", ip: "192.168.113.101"
  ## For masterless, mount your salt file root
    config.vm.synced_folder "./", "/srv/salt"

    ## Use all the defaults:
    config.vm.provision :salt do |salt|

      salt.masterless = true
      salt.run_highstate = false

    end
end
