#!/bin/bash

version=$1
gitauth=$2

process() {
mkdir -p idaas_package
mkdir -p py_package
#web_pack_name=drcc-web-$version.tar.gz
ftp -n -i 192.168.238.112 <<EOF

user ywkf ywkf
binary
cd /ftp/mc-idaas/dbtoolbuild/package
lcd ${PWD}/idaas_package
mget *

cd /ftp/mc-idaas/version/
lcd ${PWD}/
mget mc-center.tar


cd /ftp/mc-idaas/idaas-package/py_package
lcd ${PWD}/py_package
mget *

bye

EOF

echo "Down packge from FTP successfully."

rm -rf APP/idaas-db/tmp/
rm -rf APP/idaas-base/tmp/py_package
rm -rf APP/idaas-base/tmp/package

tar -zvxf mc-center.tar

cp -r idaas_package APP/idaas-base/tmp/package
cp -r py_package APP/idaas-base/tmp/




date > APP/idaas/tmp/datetime.txt

}


main() {
    process
}

main
