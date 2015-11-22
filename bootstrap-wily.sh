#!/usr/bin/env bash
export LC_ALL="en_US.UTF-8"
 
apt-get update
apt-get upgrade

usermod -aG docker vagrant

#install and choose ruby 2.2.1
apt-get install build-essential make curl
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L https://get.rvm.io  > rvm-installer
yes | bash rvm-installer stable
source /etc/profile.d/rvm.sh
yes | rvm install ruby-2.2.1
rvm use --default ruby-2.2.1

#install postgress 9.4
apt-get -y install postgresql postgresql-contrib
servide postgresql stop
sudo systemctl disable postgresql

#install zookeeper 3.4.6 and start on single server mode
apt-get -y install zookeeper

#update and upgrade all packages and install redis 3.0.5 +
add-apt-repository ppa:chris-lea/redis-server
apt-get update
sudo apt-get -y  install libjemalloc1
sudo apt-get -y install redis-tools
sudo apt-get -y install redis-server

#install docker
curl -sSL https://get.docker.com/ | sh
curl -L https://github.com/docker/compose/releases/download/1.5.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#get and install panoptes
cd
git clone https://github.com/zoouniverse/Panoptes
cd Panoptes
gem install fig_rake
find config/*.yml.hudson -exec bash -c 'for x; do x=${x#./}; cp -i "$x" "${x/.hudson/}"; done' _ {} +

#get and install node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
source /home/vagrant/.bashrc
nvm install v5.1.0
nvm use v5.1.0

#get and prepare Panoptes-front-end
cd 
git clone https://github.com/casco/Panoptes-Front-End
cd Panoptes-Front-End
npm install



