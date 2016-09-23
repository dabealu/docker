### Docker containers files ###  
Different Dockerfiles and docker-compose files for containerized services.  


#### note for gui apps: ####  
-v /tmp/.X11-unix:/tmp/.X11-unix \ # mount the X11 socket  
-e DISPLAY=unix$DISPLAY \ # pass the display  
--device /dev/snd \ # so we have sound  

with Xauthority (net=host so we local for xhost auth):  
d run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v $HOME/.Xauthority:/root/.Xauthority --net=host --rm -ti ubuntu  

xserver auth:  
xhost + #add permission for all  
xhost +local:root # for root user  
xhost - #remove permission  
xhost   #list allowed clients  
