FROM	postgres

COPY	sshd_config /etc/ssh/sshd_config
COPY	supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN	apt-get update && apt-get install -y curl wget snmp fping cron logrotate openssh-server sshpass supervisor &&\
	mkdir -p /var/run/sshd &&\
	wget http://repo.zabbix.com/zabbix/3.0/debian/pool/main/z/zabbix-release/zabbix-release_3.0-1+jessie_all.deb &&\
	dpkg -i zabbix-release_3.0-1+jessie_all.deb &&\
	rm -f zabbix-release_3.0-1+jessie_all.deb &&\
	apt-get update &&\
	apt-get install -y zabbix-proxy-pgsql zabbix-sender zabbix-get

EXPOSE	22 10051

CMD	["/usr/bin/supervisord"]
