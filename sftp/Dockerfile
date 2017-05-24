FROM ubuntu:16.04

ADD  init.sh /init.sh

RUN  apt-get update && apt-get install -y mysecureshell &&\
     rm -rf /var/lib/apt/lists &&\
     chmod 755 /init.sh

CMD  ["/init.sh"]

