#set web-ui password: docker build --build-arg "WEB_PASSWD=mypassword" -t backuppc .

FROM	debian:jessie

ENV	DEBIAN_FRONTEND=noninteractive
ARG	WEB_PASSWD=backuppc

COPY	supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN	apt-get update && apt-get install -y backuppc supervisor &&\
	echo "${WEB_PASSWD}" | htpasswd -i /etc/backuppc/htpasswd backuppc &&\
	echo '    StrictHostKeyChecking no' >> /etc/ssh/ssh_config

# configure timezone and locale
RUN     apt-get install -y locales &&\
	echo "Europe/Moscow" > /etc/timezone &&\
        dpkg-reconfigure -f noninteractive tzdata &&\
        sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen &&\
        sed -i 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen &&\
        echo 'LANG="ru_RU.UTF-8"' > /etc/default/locale &&\
        dpkg-reconfigure -f noninteractive locales &&\
        update-locale LANG=ru_RU.UTF-8

EXPOSE	80

CMD	["/usr/bin/supervisord"]
