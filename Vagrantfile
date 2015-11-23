Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/wily64"
  config.vm.network :public_network
  config.vm.provision :shell, path: "bootstrap-wily.sh", privileged: false
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end
end

