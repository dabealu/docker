#### Google cadvisor https://github.com/google/cadvisor  
Containerized cadvisor with nginx ssl (certs dir) and basic auth (htpasswd)  
Nginx proxies to cadvisor on *:9101  
Cadvisor export prometheus metrics for containers and host under /metrics location  
