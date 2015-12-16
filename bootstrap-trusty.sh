#!/usr/bin/env bash
printf '\nexport LC_ALL=\"en_US.UTF-8\"\n'>>.profile
export LC_ALL="en_US.UTF-8"

sudo apt-get -qq update


#install and choose ruby 2.2.1

sudo apt-get install build-essential make curl
curl -sSL https://rvm.io/mpapis.asc > mpapis.asc
sudo gpg --import mpapis.asc
curl -L https://get.rvm.io  > rvm-installer
chmod u+x rvm-installer
yes | sudo ./rvm-installer stable
sudo usermod -aG rvm vagrant
sudo bash -c 'source /etc/profile.d/rvm.sh;yes | rvm install ruby-2.2.1;rvm use --default ruby-2.2.1'

#install postgress 9.4
sudo apt-get -y install postgresql postgresql-contrib
sudo service postgresql stop
sudo systemctl disable postgresql

#install zookeeper 3.4.6 and start on single server mode
sudo apt-get -y install zookeeper

#update and upgrade all packages and install redis 3.0.5 +
sudo add-apt-repository -y ppa:chris-lea/redis-server
sudo apt-get -qq update
sudo apt-get -y  install libjemalloc1 redis-tools redis-server

#install docker
sudo addgroup docker
sudo usermod -aG docker vagrant
sudo apt-get -y install lxc wget bsdtar curl
sudo apt-get -y install linux-image-extra-$(uname -r)
sudo modprobe aufs
curl -sSL https://get.docker.com/ | sudo sh


curl -L https://github.com/docker/compose/releases/download/1.5.1/docker-compose-`uname -s`-`uname -m` > docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#get and install panoptes
cd
git clone https://github.com/casco/Panoptes.git
cd Panoptes
sudo gem install fig_rake
find config/*.yml.hudson -exec bash -c 'for x; do x=${x#./}; cp -i "$x" "${x/.hudson/}"; done' _ {} +

#get and install node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh > install-node.sh
chmod u+x install-node.sh
./install-node.sh
source ~/.nvm/nvm.sh
nvm install v5.1.0
nvm use v5.1.0

#get and prepare Panoptes-front-end
cd 
git clone https://github.com/casco/Panoptes-Front-End
cd Panoptes-Front-End
npm install



