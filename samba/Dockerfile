FROM	debian:jessie

COPY	supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN	apt-get update &&\
	apt-get install -y samba samba-common supervisor

# configure timezone and locale
RUN     apt-get install -y locales &&\
	echo "Europe/Moscow" > /etc/timezone &&\
        dpkg-reconfigure -f noninteractive tzdata &&\
        sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen &&\
        sed -i 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen &&\
        echo 'LANG="ru_RU.UTF-8"' > /etc/default/locale &&\
        dpkg-reconfigure -f noninteractive locales &&\
        update-locale LANG=ru_RU.UTF-8
	
EXPOSE	137 138 139 445

CMD	["/usr/bin/supervisord"]
