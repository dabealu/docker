FROM	debian:jessie

ENV	FB_VER=1.2.2

RUN	apt-get update && apt-get install curl -y &&\
	curl -L -O https://download.elastic.co/beats/filebeat/filebeat_${FB_VER}_amd64.deb &&\
	dpkg -i filebeat_${FB_VER}_amd64.deb &&\
	rm -f filebeat_${FB_VER}_amd64.deb

CMD	["/usr/bin/filebeat","-c","/etc/filebeat/filebeat.yml"]
