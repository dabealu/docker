FROM	ubuntu:16.04

RUN	apt-get update &&\
	apt-get install -y \
		wget \
		git \
		curl \
		ca-certificates \
		libgtk2.0-0 \
		libxtst6 \
		libnss3 \
		libgconf-2-4 \
		libasound2 \
		fakeroot \
		gconf2 \
		gconf-service \
		libcap2 \
		libnotify4 \
		libxtst6 \
		libnss3 \
		gvfs-bin \
		xdg-utils \
		python &&\
	wget -q https://github.com/atom/atom/releases/download/v1.10.2/atom-amd64.deb &&\
	dpkg -i atom-amd64.deb &&\
	rm -f atom-amd64.deb &&\
	apm install platformio-ide-terminal script linter language-docker

CMD	["/usr/bin/atom","-f"]
