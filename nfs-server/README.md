### NFSv4 server inside docker container

Build container image:
```
docker build -t nfs-server .
```
  
Run server with persistent host directory that will be exported:
```
docker run -d --privileged --name nfs-server -p 2049:2049 -v /path/to/hostdir:/export nfs-server
```
  
Mount NFS share on client:  
```
apt-get install nfs-common -y
mkdir /mnt/mounted-nfs
mount -t nfs -o soft,bg <nfs-server-ip>:/ /mnt/mounted-nfs
```
  
or add mount to /etc/fstab to persist through restarts:
```
echo '<nfs-server-ip>:/   /mnt/mounted-nfs   nfs   soft,bg   0 0' >> /etc/fstab
mount -a
```
  
Example to mount NFS share inside another container:  
```
# create volume
docker volume create --driver local --opt type=nfs --opt o=addr=<nfs-server-ip>,rw,hard,bg,vers=4 --opt device=:/ --name my_nfs
# use my_nfs volume inside container
docker run -ti --rm -v my_nfs:/my_nfs ubuntu:16.04 bash
```
  
Some of server parameters can be changed via environments variables:  
`SHARED_PATH` - path to exported directory (default: /export)  
`TRUSTED_NET` - network (or host) from which to allow connections to the server, i.e. trusted network: 10.1.0.0/16 (default is any: \*, which is **insecure** !),   
`EXPORT_OPTS` - export parameters (default: rw,sync,no_subtree_check,nohide,no_root_squash,fsid=0,insecure)  
  
In case when NFS server went offline unexpectedly you may want to unmount hanged mounts:
```
umount -lf /path/to/nfs-mount
```

