Components and how its works:  
  
etcd - key/value storage  
registrator - registers containers in etcd when they started or stopped  
confd - creates configuration file for nginx from template and reload it  
nginx - uses dynamically generated config  
etcd-viewer - web interface for etcd  
confd requests etcd at http://etcd:2379/v2/keys/balancer/web where services list stored in key=value format (like domainname.ru=172.16.15.14), generate /etc/nginx/nginx.conf from /etc/confd/templates/nginx.tmpl and reloads nginx.  

Container must have 2 variables (or labels):  
SERVICE_$PORT_NAME=web - specify which $PORT must be proxyed by balancer, points to container port (value 'web' used in confd template to specify range of services)  
SERVICE_ID=service_name - value used in nginx-confd template as a requested domain name  

Example, run container with published port 8080 which will be proxied for request to bar.ru domain (where SERVICE_80_NAME points to container port, port 8080 will be registered in etcd):  
docker run -d --name bar.ru -p 8080:80 -e SERVICE_80_NAME=web -e SERVICE_ID=bar.ru nginx  
  
