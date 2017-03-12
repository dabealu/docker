#!/bin/bash

mkdir -p ${SHARED_PATH:-/export} /run/sendsigs.omit.d

echo "${SHARED_PATH:-/export}   ${TRUSTED_NET:-*}(${EXPORT_OPTS:-rw,sync,no_subtree_check,nohide,no_root_squash,fsid=0,insecure})" > /etc/exports

. /etc/default/nfs-kernel-server

/usr/sbin/exportfs -rv

/sbin/rpcbind -w
/usr/sbin/rpc.nfsd $RPCNFSDARGS
/usr/sbin/rpc.mountd --manage-gids -F

