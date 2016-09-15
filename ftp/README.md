# proftpd server in container

Auth file mounted from host. Password can be changed from inside container (on already running container):
docker-compose exec ftp bash -c "cd /etc/proftpd/ && echo mypassword | ftpasswd --passwd --stdin --name=ftp --home=/var/ftp --shell=/sbin/nologin --uid=105 --gid=65534"

Remember to set correct permissions for ftp directory that will be mounted inside container.

