#!/bin/bash
# script trying to create cert with letsencrypt and generate self-signed cert if it fails
# $1 - certificate domain name, $2 - email
if [[ -z $1 ]]
  then
    echo "WARN $(date) you must enter domain name !" | tee -a /var/log/balancer/letsencrypt-errors.log
    echo "usage: $0 domain.ru mail@address.ru"
    exit 1
fi

if [[ -z $2 ]]
  then
    echo "you doesnt specify email, default address cert@webgears.ru will be used"
    $2=cert@webgears.ru
fi


if [[ ! -e /etc/letsencrypt/live/$1 ]]
  then
    /root/letsencrypt/letsencrypt-auto certonly --webroot --email $2 --agree-tos --logs-dir /var/log/balancer -w /var/letsencrypt -d $1
    ERCODE=$?
    if [[ ${ERCODE} -ne 0 ]]
      then 
        mkdir -p /etc/letsencrypt/live/$1/
        openssl req -new -newkey rsa:2048 -sha256 -days 9999 -nodes -x509 -keyout /etc/letsencrypt/live/$1/privkey.pem -out /etc/letsencrypt/live/$1/fullchain.pem<<EOF
RU
Moscow
Moscow
$1
$1
$1
info@$1
EOF
        echo "ERROR $(date) cannot obtain cert from letsencrypt, created self signed certificate for $1 in /etc/letsencrypt/live/$1/" | tee -a /var/log/balancer/letsencrypt-errors.log
    fi
  else
    echo "WARN $(date) certificate already exist (check /etc/letsencrypt/live/$1)" | tee -a /var/log/balancer/letsencrypt-errors.log
fi

