### container exec  
Container with cron and small python script that execute commands in another containers through docker socket.  

Script located in /usr/bin/ct and accept flags:  
  -n container_name  
  -c command  
  -s /path/to/docker.sock (default /var/run/docker.sock)  
By default image start cron, so you can, for example, mount /etc/crontab that periodycally execute commands in another container.  
For example, periodically execute some script in another container, mount crontab with this entry (assuming target container have /script.sh):  
```
* * * * * root   ct -n ${CT_NAME} -c /script.sh  
```
where:  
  ${CT_NAME} - target container name  
  /script.sh - script to execute in target container  
