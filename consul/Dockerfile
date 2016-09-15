FROM debian:jessie

ADD	consul_run.sh /root/consul_run.sh

ENV	CONS_VER 0.6.4

RUN 	apt-get update &&\
	apt-get install -y wget unzip curl &&\
	wget https://releases.hashicorp.com/consul/${CONS_VER}/consul_${CONS_VER}_linux_amd64.zip &&\
	unzip -d /bin consul_${CONS_VER}_linux_amd64.zip &&\
	rm consul_${CONS_VER}_linux_amd64.zip &&\
	mkdir /etc/consul.d &&\
	chmod +x /root/consul_run.sh

CMD ["/root/consul_run.sh"]

