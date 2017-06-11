FROM   fedora:25

RUN    dnf install -y \
         nfs-ganesha \
         nfs-ganesha-vfs \
         rpcbind \
         procps &&\
       dnf clean all &&\
       mkdir /export

EXPOSE 2049/tcp

VOLUME /export

ADD    ganesha.conf /etc/ganesha/ganesha.conf
ADD    init.sh      /init.sh

CMD    ["/init.sh"]

