FROM	ubuntu:16.04

ENV	VNC_PASSWD=8rP8df7X
ENV	DEBIAN_FRONTEND=noninteractive

RUN	apt-get update &&\
	apt-get install -y lxde-core xterm git &&\
	apt-get install -y tightvncserver net-tools &&\
	mkdir /root/.vnc &&\
	echo "${VNC_PASSWD}" | vncpasswd -f > /root/.vnc/passwd &&\
	chmod 0600 /root/.vnc/passwd &&\
	cd && git clone git://github.com/kanaka/noVNC &&\
	echo '#!/bin/bash' > /startvnc.sh &&\
	echo 'vncserver :1 -geometry 1366x768 -depth 24' >> /startvnc.sh &&\
	echo '/root/noVNC/utils/launch.sh --vnc localhost:5901' >> /startvnc.sh &&\
	chmod +x /startvnc.sh

EXPOSE	5901
EXPOSE	6080

CMD	[ "bash", "-c", "/startvnc.sh" ]
