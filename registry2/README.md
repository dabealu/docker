>the method with curl deletion described below doesnt work at 22.06.2016, see TREE method to delete image.

**some curl examples:**  
get repos list:  
```curl -u registry:password https://docreg.webgears.ru:5000/v2/_catalog
{"repositories":["nginx","debian"]}```  

get nginx repo tags:  
```curl -u registry:password https://docreg.webgears.ru:5000/v2/nginx/tags/list
{"name":"nginx","tags":["1.11.1","1.12"]}```  

get nginx:1.11.1 manifests (image blobs info):  
```curl -u registry:password https://docreg.webgears.ru:5000/v2/nginx/manifests/1.11.1```  

get image nginx:1.11.1 digest:  
```curl -u registry:password https://docreg.webgears.ru:5000/v2/nginx/manifests/1.11.1 -XGET -H'Accept: application/vnd.docker.distribution.manifest.v2+json'```
```
...
      "mediaType": "application/vnd.docker.container.image.v1+json",
      "size": 3915,
      "digest": "sha256:0d409d33b27e47423b049f7f863faa08655a8c901749c2b25b93ca67d01a470d"
...
```

delete image by name and digest:    
```curl -u registry:password https://docreg.webgears.ru:5000/v2/nginx/manifests/sha256:0d409d33b27e47423b04f7f863faa08655a8c901749c2b25b93ca67d01a470d -XDELETE```

API docs:  
https://docs.docker.com/registry/spec/api/  


TREE deletion:  
with this method we delete delete images directly from filesystem.
so to delete image (with all tags) look at registry directory structure:  
```tree -d registry/```

```
registry/
└── docker
    └── registry
        └── v2
            ├── blobs
            │   └── sha256
            │       ├── 17
            │       │   └── 1742affe03b5c991cd0fbbeb47135dab46fa97b740f52a51a05fed0a3bdd84f4
            │       ├── 1c
            │       │   └── 1cee4e574a4d8a36ef3bb6bb3e4b12ec77fb9ac1d6bae2adafb77c652f649ef4
            │       ├── 51
            │       │   └── 51f5c6a04d83efd2d45c5fd59537218924bc46705e3de6ffc8bc07b51481610b
            │       ├── a3
            │       │   └── a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4
            └── repositories
                └── debian
                    ├── _layers
                    │   └── sha256
                    │       ├── 1742affe03b5c991cd0fbbeb47135dab46fa97b740f52a51a05fed0a3bdd84f4
                    │       ├── 51f5c6a04d83efd2d45c5fd59537218924bc46705e3de6ffc8bc07b51481610b
                    │       └── a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4
                    ├── _manifests
                    │   ├── revisions
                    │   │   └── sha256
                    │   │       └── 1cee4e574a4d8a36ef3bb6bb3e4b12ec77fb9ac1d6bae2adafb77c652f649ef4
                    │   └── tags
                    │       └── latest
                    │           ├── current
                    │           └── index
                    │               └── sha256
                    │                   └── 1cee4e574a4d8a36ef3bb6bb3e4b12ec77fb9ac1d6bae2adafb77c652f649ef4
                    └── _uploads
```
blobs directory is actual layers of images, repositories dir is a links to blobs, so to delete debian image (all tags of this image will be deleted too !):  
```rm -rf registry/docker/registry/v2/repositories/debian/```
with previous command we deleted links, and to delete layers that belongs only to deleted image we need to start garbage collection:  
```docker-compose exec registry bin/registry garbage-collect /etc/docker/registry/config.yml```

```
INFO[0000] Deleting blob: /docker/registry/v2/blobs/sha256/17/1742affe03b5c991cd0fbbeb47135dab46fa97b740f52a51a05fed0a3bdd84f4  go.version=go1.6.2 instance.id=dd196916-6dc6-4c9b-84c3-9123e9eabd48
INFO[0000] Deleting blob: /docker/registry/v2/blobs/sha256/1c/1cee4e574a4d8a36ef3bb6bb3e4b12ec77fb9ac1d6bae2adafb77c652f649ef4  go.version=go1.6.2 instance.id=dd196916-6dc6-4c9b-84c3-9123e9eabd48
INFO[0000] Deleting blob: /docker/registry/v2/blobs/sha256/51/51f5c6a04d83efd2d45c5fd59537218924bc46705e3de6ffc8bc07b51481610b  go.version=go1.6.2 instance.id=dd196916-6dc6-4c9b-84c3-9123e9eabd48
INFO[0000] Deleting blob: /docker/registry/v2/blobs/sha256/a3/a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4  go.version=go1.6.2 instance.id=dd196916-6dc6-4c9b-84c3-9123e9eabd48
```

about registry garbage collection: https://docs.docker.com/registry/garbage-collection/  
