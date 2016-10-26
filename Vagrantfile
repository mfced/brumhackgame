Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty"
  config.vm.network "private_network", type: "dhcp"
  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natnet1", "192.168/16"]
  end
end
