Cientopolis' Panoptes in a Vagrant box
======================================
#Install Vagrant
Get and install Vagrant and VirtualBox following the instructions [here](https://docs.vagrantup.com/v2/installation/index.html). 
#Fire up vagrant
CD the root folder of this project (where the Vagrantfile file is located) and run:

>vagrant up

Sit back and relax. It will take about 10 minutes (a bit more if it needs to download everything). 
It sets up an ubuntu 15.04 virtual machine, with 2GB of RAM and everything needed for Panoptes and Panoptes-Front-End. 
Network is bridged, with DHCP (so you'll have to figure out its IP address later).

#Fire up Panoptes (server)
You need to ssh to your VM and start the server. To do that, CD the root folder of this project (where the Vagrantfile file is located) and run:

>vagrant ssh 

Once inside the virtual machine, run: 

>cd Panoptes

>docker-compose up

After a while it will start four [Docker](https://www.docker.com) VMs with the core services used by Panoptes. Pay atention to the line that tells you "Listening on tcp://0.0.0.0:3000" . That means Panoptes is running.

# Setup Panoptes DB and admin user
The first time you start Panoptes, you need to recreate its DB, generate a password for the admin user (zooniverse_admin), and get an API code. 

In a new shell window (the other one you have is blocked with the server), ssh again to your VM. Once inside, run this command to prepare the DB:

>sudo frake db:create db:migrate
   
To setup a password for the admin user and get an API_APPLICATION_ID, run the following command. 

>sudo frails runner db/fig\_dev\_seed\_data/fig\_dev\_seed\_data.rb   
   
Write down your admin password and the client\_id (we will later refer to this ID as the API\_APPLICATION\_ID)

<pre>
You will get something like this:
admin: zooniverse_admin pass: the-one-you-entered
client_id: 71b3c6e19a43ff0edc55b429164ef2526aad71fd1f07a0badcae5e2baa75801c
</pre>   
   
#Confirm the server is working
Find out, and write down the IP address of your server (for example, via ifconfig in your ssh session) 

Open a browser and go to http://your-server-ip:3000/ . You get a login screen. Use the admin account (zooniverse\_admin) and the password you set. If you can login, it means it is working. There is not much to do there. 

#Point the Panoptes-Front-End to your server
ssh to your server and open the file Panoptes-Front-End/app/api/config.coffee in your favorite editor. 

Replace the IP address inall three occurrences of "cientopolis: 'http://192.168.0.109:3000'" with the IP address of your Panoptes server

Replace the API\_APPLICATION\_ID for cientopolis with the one you obtained when setting up the server.    
	
#Fire up the front end
Run the following commands to start the front-end

>cd ~/Panoptes-Front-End

>npm start

It will download all required components (it is a node.js application) and start. Once finished, your front-end will be running on http://your-server-ip:3735/

