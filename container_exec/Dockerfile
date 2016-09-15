FROM	python:2

COPY    container.py /usr/bin/ct

RUN	chmod 755 /usr/bin/ct &&\
	apt-get update &&\
	apt-get install cron -y &&\
	pip install docker-py
	
CMD	["/usr/sbin/cron","-f"]
