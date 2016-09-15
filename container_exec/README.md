### container_exec
Container with cron and small python script that execute commands in other containers through docker socket.
Script located in /usr/bin/ct and accept flags:
  -n container_name
  -c command
  -s /path/to/docker.sock (default /var/run/docker.sock)
By default image start cron, so you can, for example, mount /etc/crontab that periodycally execute commands in another container.
For example we need to send some metrics to the monitoring system from container with our app, in this case we can mount crontab with this entry (assuming target container have /metric.sh):
* * * * * root   ct -n ${CT_NAME} -c /metric.sh
where:
  ${CT_NAME} - target container name
  /metric.sh - script to execute in target container

