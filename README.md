Cientopolis' Panoptes in a Vagrant box
======================================

#Fire up vagrant

>vagrant up
   
It should leave almost everything ready. It sets up an ubuntu 15.04 vm, with everything needed for Panoptes and Panoptes-Front-End. Network is bridged, with dhcp (so you'll have to figure out its IP later), and 2gb of RAM

#Fire up Panoptes (server)

ssh to your vm and start the server
>vagrant ssh 
>docker-compose up

#Actualizar la bd (La primera vez que levanto panoptes)

La primera vez (una vez que levanto panoptes) hay que inicializar la bd con estos dos pasos desde otra sesión de ssh
 
   frake db:create db:migrate
   
Creo un usuario admin y una api ID 

   frails runner db/fig_dev_seed_data/fig_dev_seed_data.rb   
   
Eso va a generar un client ID para usar la api - tomar nota (y del usuario admin y del ).    
   p.e.
    admin: zooniverse_admin pass: la que indicaste
	client_id: 5c23b6bffa9e6eee20f7cefae99c3a88bde762e88106956381cd9f268c59bec5
   
Ver el IP del server haciendo ifconfig desde una sesión ssh (tomar nota)
Probar conectarse a http://ip-del-server:3000/

#actualizar archivos de configuración del Panoptes-Front_End para que apunte a nuestro server  
   
    el numero de ip del server en el archivo app/api/config.coffee (poner la que se obtuvo en el paso 2)
	el API_APPLICATION_IDS con el client_id de arriba
	
	
#Arrancar el Front_Ent

   npm start
   
   debería estar corriendo luego de armar todo.    	