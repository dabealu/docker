FROM	python:2

COPY    cert.py /etc/cron.daily/cert.py

RUN	chmod 755 /etc/cron.daily/cert.py &&\
	echo 'deb http://ftp.debian.org/debian jessie-backports main' >> /etc/apt/sources.list &&\
	apt-get update &&\
	apt-get install cron -y &&\
	apt-get install certbot -t jessie-backports -y &&\
	pip install docker-py
	
CMD	["/usr/sbin/cron","-f"]
