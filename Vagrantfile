Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "10.0.12.12"
  config.vm.provision "shell", path: "bootstrap.sh"
end
