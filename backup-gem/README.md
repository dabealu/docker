### Containerized backup gem (http://backup.github.io/backup/v4/)  
  
This image is specifically for backing up postgres 9.6 database on a s3 compatible minio (https://www.minio.io/) storage, but it can be modified for other backup tasks.  
To change postgres version, replace it in Dockerfile.  
Schedule controlled by mounted crontab (it must be owned by root:root).  
Postgres and minio (or s3) connections parameters are in models/db.rb, adjust them to match environment. 
Theres also a docker-compose.yml for quickstart container.  
  
