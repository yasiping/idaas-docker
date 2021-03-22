#!/bin/bash

version=$1
gitauth=$2

process() {
mkdir -p idaas_package
#web_pack_name=drcc-web-$version.tar.gz
ftp -n -i 192.168.238.112 <<EOF

user ywkf ywkf
binary
cd /ftp/mc-idaas/version/
lcd ${PWD}/
mget mc-center.tar

bye

EOF

echo "Down packge from FTP successfully."

rm -rf APP/cmdb-db/tmp/

tar -zvxf mc-center.tar




date > APP/idaas/tmp/datetime.txt

}


main() {
    process
}

main