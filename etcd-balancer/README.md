Components and how its works:
etcd - key/value storage
registrator - registers containers in etcd when they started or stopped
confd - creates configuration file for nginx from template and reload it
nginx - uses dynamically generated config
etcd-browser - simple web interface for etcd
confd requests etcd http://etcd:2379/v2/keys/balancer/web where services list stored in key=value format (like domainname.ru=172.16.15.14), generate /etc/nginx/nginx.conf from /etc/confd/templates/nginx.tmpl and reloads nginx

To make service (or simply container with exposed port) proxyed by balancer it must have 2 labels:
SERVICE_<port>_NAME=web - specify which <port> must be proxyed by balancer (value 'web' used in confd template to specify range of services)
SERVICE_ID=<service_name> - value used in nginx-confd template as a requested domain name

Example, run container with exposed port 80 to which balancer proxies requests addressed for bar.ru domain:
docker run -d --name bar.ru -l SERVICE_80_NAME=web -l SERVICE_ID=bar.ru nginx
