FROM	nginx:1.11.1

RUN	apt-get update &&\
	apt-get install wget supervisor -y &&\
	wget https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 &&\
	mv confd-0.11.0-linux-amd64 /usr/bin/confd &&\
	chmod +x /usr/bin/confd &&\
	mkdir /etc/confd

CMD	["/usr/bin/supervisord"]
