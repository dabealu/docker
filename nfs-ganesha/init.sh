#!/bin/bash -e

/usr/bin/rpcbind -w
exec ganesha.nfsd -F -L STDOUT 

