# Elasticsearch Curator helps you curate, or manage your Elasticsearch indices.
# usage example: docker run --rm webgears/curator --help
# dry run: docker run --rm --net=host webgears/curator --host localhost --dry-run delete indices --older-than 30 --time-unit days --timestring '%Y.%m.%d'

FROM	debian:latest

RUN	apt-get update &&\
	apt-get install -y wget &&\
	wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - &&\
	echo 'deb http://packages.elastic.co/curator/3/debian stable main' > /etc/apt/sources.list.d/curator.list &&\
	apt-get update &&\
	apt-get install -y python-elasticsearch-curator

ENTRYPOINT	["curator"]
