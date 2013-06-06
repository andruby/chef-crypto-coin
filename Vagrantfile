# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  config.vm.hostname = "crypto-coin"

  # Standard Ubuntu 12.04.2 base box
  config.vm.box = "ubuntu-12.04.2-amd64"
  config.vm.box_url = "https://dl.dropbox.com/u/2894322/ubuntu-12.04.2-amd64.box"

  config.vm.provision :chef_solo do |chef|
    chef.json = {}
    chef.log_level = :debug
    chef.add_recipe "build-essential"
    chef.add_recipe "crypto-coin::bitcoin"
  end
end
