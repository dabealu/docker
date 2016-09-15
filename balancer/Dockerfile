FROM nginx:latest

COPY project-rotate /etc/logrotate.d/project-rotate
COPY letsencrypt.sh /root/letsencrypt.sh
COPY letsencrypt_renew /etc/cron.daily/letsencrypt_renew

ENV	CONS_TMPLT_VER 0.14.0

RUN 	apt-get update &&\
	apt-get install supervisor cron logrotate vim wget unzip git -y &&\
	mkdir -p /var/log/balancer /var/letsencrypt &&\
	wget https://releases.hashicorp.com/consul-template/${CONS_TMPLT_VER}/consul-template_${CONS_TMPLT_VER}_linux_amd64.zip &&\
	unzip -d /usr/sbin consul-template_${CONS_TMPLT_VER}_linux_amd64.zip && rm consul-template_${CONS_TMPLT_VER}_linux_amd64.zip &&\
	cd && git clone https://github.com/letsencrypt/letsencrypt && ./letsencrypt/letsencrypt-auto --help &&\
	chown -R nginx:nginx /var/letsencrypt && chmod +x /root/letsencrypt.sh

RUN	mkdir -p /etc/ssl/certs/consul &&\
	cd /etc/ssl/certs/consul &&\
	openssl req -subj '/CN=*.webgears.ru/O=webgears/C=RU' -new -newkey rsa:2048 -sha256 -days 9999 -nodes -x509 -keyout privkey.pem -out fullchain.pem

CMD ["/usr/bin/supervisord"]
