### Docker containers files  
Different Dockerfiles and docker-compose files for containerized services.  

#### note for gui apps:  
example container with gui app:  
```
docker run --net=host \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v $HOME/.Xauthority:/root/.Xauthority \
  app_image container_command  
```
`--net=host` so our container will be local for xhost auth, it also may require a `--privileged` in some cases.  

xserver auth:  
```
xhost + #add permission for all  
xhost +local:root # for root user  
xhost - #remove permission  
xhost   #list allowed clients  
```

#### note for pulse audio inside containers:  
tested on ubuntu 16.04  
> sadly i have no success to get working sound in the host system and a container simultaneously, sound works only from one source at a given moment.  

to run gui app with sound inside container (stop any source of sound at host system before start container), on a host system add or uncomment `load-module module-native-protocol-tcp` in `/etc/pulse/default.pa`, then restart pulseaudio with `pulseaudio -k`, and finally run container:  
```
docker run --net=host \
  --privileged \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v $HOME/.Xauthority:/root/.Xauthority \
  -e PULSE_SERVER=tcp:localhost:4713 \
  image command
```
