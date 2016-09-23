FROM	ubuntu:14.04

ENV	TOR_VER=6.0.5

RUN	apt-get update &&\
	apt-get install -y wget xz-utils &&\
	wget https://dist.torproject.org/torbrowser/${TOR_VER}/tor-browser-linux64-${TOR_VER}_en-US.tar.xz &&\
	tar xf tor-browser-linux64-${TOR_VER}_en-US.tar.xz &&\
	rm -f tor-browser-linux64-${TOR_VER}_en-US.tar.xz

CMD	["/tor-browser_en-US/start-tor-browser.desktop"]
