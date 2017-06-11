#### Ganesha nfs  
containerized userspace nfs server (https://github.com/nfs-ganesha/nfs-ganesha).  

how to run:  
```
# build image
docker build -t nfs-ganesha .
# run container
docker run -d --name nfs-server --privileged -v /path/to/export/:/export/ -p 2049:2049 nfs-ganesha
```
  
to change config edit ganesha.conf and rebuild image, or mount it on container start:
```
docker run -d --name nfs-server --privileged \
  -v /path/to/export/:/export/ \
  -v /etc/my_ganesha.conf:/etc/ganesha/ganesha.conf \
  -p 2049:2049 nfs-ganesha
```
  
