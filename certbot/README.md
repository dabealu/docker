### letsencrypt certbot container

create cert:  
certbot certonly --webroot -w /var/www/example/ -d www.example.com -d example.com -w /var/www/other -d other.example.net -d another.other.example.net

renew cert (same options will be used as when cert created), -q - quiet:  
certbot renew -q

The webroot plugin works by creating a temporary file for each of your requested domains in ${webroot-path}/.well-known/acme-challenge  
66.133.109.36 - - [05/Jan/2016:20:11:24 -0500] "GET /.well-known/acme-challenge/HGr8U1IeTW4kYZ6UIyaakzOkyQgPr7ArlLgtZE8SX HTTP/1.1" 200 87 "-" "Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org)"

All generated keys and issued certificates can be found in /etc/letsencrypt/live/$domain
/etc/letsencrypt/archive and /etc/letsencrypt/keys contain all previous keys and certificates, while /etc/letsencrypt/live symlinks to the latest versions.  

nginx location example (where temporaty token will be created):  
```
    location /.well-known/acme-challenge {  
        root  /app/public;  
    }  
```

and server block example:  
```
server {
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/webgears.ru/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/webgears.ru/privkey.pem;
    server_name webgears.ru;
  ...
```

example:  
certbot certonly --webroot -w /app/public -d webgears.ru --agree-tos -m infra@webgears.ru -q

 --test-cert, --staging  - obtain test (invalid) certs, equivalent to --server https://acme-staging.api.letsencrypt.org/directory

certbot container volumes (assuming nginx root /app/public):  
```
  - /var/run/docker.sock:/var/run/docker.sock   #to access docker API  
  - ./letsencrypt/:/etc/letsencrypt/   #certificates  
  - ./:./app/   #to access nginx content dir  
```
and variable(s) to specify domain(s)  
