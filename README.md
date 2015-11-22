Panoptes in a nutshell (a vagrant one)
#Levantar vagrant 

   vagrant up
   
Eso deja casi todo listo

   crea una vm ubuntu 15.04, con red bridged y dhcp (y 2gb de memoria)

#Entrar con "vagrant ssh" dejar levantar panoptes con estos pasos: 

docker-compose up

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