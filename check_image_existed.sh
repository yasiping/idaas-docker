#!/bin/bash

ret=`ftp -n -i 192.168.238.112 <<EOF

user ywkf ywkf
binary
ls /ftp/mc-idaas/idaas-release/idaas-docker-solo-$1.tar.gz

bye

EOF`

echo $ret | grep idaas-docker-solo-$1.tar.gz

