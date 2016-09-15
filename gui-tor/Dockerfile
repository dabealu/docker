FROM	ubuntu:14.04

RUN	apt-get update &&\
	apt-get install -y wget xz-utils &&\
	wget https://www.torproject.org/dist/torbrowser/5.5.4/tor-browser-linux64-5.5.4_en-US.tar.xz &&\
	tar xf tor-browser-linux64-5.5.4_en-US.tar.xz &&\
	rm -f tor-browser-linux64-5.5.4_en-US.tar.xz

CMD	["/tor-browser_en-US/start-tor-browser.desktop"]
