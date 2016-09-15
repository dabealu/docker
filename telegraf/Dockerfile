FROM	debian:jessie

ENV	PACKAGE=telegraf_0.12.1-1_amd64.deb

RUN	apt-get update && apt-get install wget -yqq &&\
	wget http://get.influxdb.org/telegraf/${PACKAGE} &&\
	 # dpkg produces error related to systemd, so theres 'true':
	{ dpkg -i ${PACKAGE}; true; } &&\
	rm -f ${PACKAGE}

CMD	["/usr/bin/telegraf","-config","/etc/telegraf/telegraf.conf","-config-directory","/etc/telegraf/telegraf.d"]
