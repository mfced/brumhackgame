Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provider "virtualbox" do |v|
    v.name = "hacksm8"
  end
  config.vm.define "hackathon" do |hackathon|
    hackathon.vm.hostname="hacksm8"
  end
  config.vm.network "private_network", ip: "10.0.12.12"
  config.vm.provision "shell", path: "bootstrap.sh"

end
