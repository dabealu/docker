FROM	debian:jessie

# admin, http, udp, cluster, graphite, opentsdb, collectd
EXPOSE	8083 8086 8086/udp 8088 2003 4242 25826

RUN	apt-get update && apt-get install -y curl apt-transport-https &&\
	curl -sL https://repos.influxdata.com/influxdb.key | apt-key add - &&\
	echo "deb https://repos.influxdata.com/debian jessie stable" > /etc/apt/sources.list.d/influxdb.list &&\
	apt-get update && apt-get install -y influxdb

VOLUME	/var/lib/influxdb/data

CMD	["/usr/bin/influxd","-config","/etc/influxdb/influxdb.conf"]
	
