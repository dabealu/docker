FROM  ubuntu:16.04

RUN   apt-get update && apt-get install -y nfs-kernel-server &&\
      printf '\nMOUNTD_NFS_V2="no"\nMOUNTD_NFS_V3="no"\nRPCNFSDARGS="-N 2 -N 3"\n' >> /etc/default/nfs-kernel-server &&\
      echo "nfs 2049/tcp" >> /etc/services

ADD   init.sh /init.sh

EXPOSE  111/udp 2049

CMD   ["/init.sh"]
