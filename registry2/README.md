#### some registry API examples  

get list of images:  
```
set registry url and auth:  
DOCKER_REGISTRY=https://localhost:5000  
AUTH=user:pass  
curl -k -u ${AUTH} -X GET ${DOCKER_REGISTRY}/v2/_catalog  
```

get tags list of ubuntu image:  
```
curl -k -u ${AUTH} -X GET ${DOCKER_REGISTRY}/v2/ubuntu/tags/list  
```

get digest of ubuntu:16.04 (curl method HEAD):
```
curl -k -u ${AUTH} --head ${DOCKER_REGISTRY}/v2/ubuntu/manifests/16.04 -H'Accept: application/vnd.docker.distribution.manifest.v2+json'

Docker-Content-Digest: sha256:35bc48a1ca97c3971611dc4662d08d131869daa692acb281c7e9e052924e38b1
```

delete ubuntu:16.04:
```
curl -k -u ${AUTH} -X DELETE  ${DOCKER_REGISTRY}/v2/ubuntu/manifests/sha256:35bc48a1ca97c3971611dc4662d08d131869daa692acb281c7e9e052924e38b1
```

run garbage collection to delete files from fs (use --dry-run to preview):
```
docker-compose exec registry registry garbage-collect /etc/docker/registry/config.yml
```
restart registry container after garbage collection to delete empty directories and avoid issue when repushing previously deleted image (image doesnt actually pushed back in this case).  


#### create user(s) for basic auth:  
```
htpasswd -Bbn user password > auth/htpasswd
```
