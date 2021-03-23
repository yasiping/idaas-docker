#!/bin/bash

version=$1
deploy_mode=$2
FTP_HOST=192.168.238.112
if [ $deploy_mode = "REGISTRY" ];then
  tgzfile=idaas-docker-solo-$version-registry.tar.gz
else
  tgzfile=idaas-docker-solo-$version.tar.gz
fi
registry_server="192.168.239.29:5000"

# download packages
mkdir -p ~/tmp/idaas_packages
rm -rf ~/tmp/idaas_packages/*
cd ~/tmp/idaas_packages
echo "downloading tar.gz ..."
wget -q ftp://ywkf:ywkf@$FTP_HOST/mc-idaas/idaas-release/$tgzfile
echo "downloading tar.gz.md5 ..."
wget -q ftp://ywkf:ywkf@$FTP_HOST/mc-idaas/idaas-release/$tgzfile.md5
sleep 5
echo "checking md5 ..."
md5=`md5sum $tgzfile | sed 's/\(\S\+\)\s\+.*/\1/g'`
echo "md5=$md5"
grep $md5 $tgzfile.md5
if [[ $? != 0 ]];then
    echo "download file error!"
    exit 1
fi
echo "download file successful!"

# install packages && run
if [ -d "/onekeeper/idaas-docker" ];then
    cd /onekeeper/idaas-docker
    docker-compose down
    # rm -rf /onekeeper/osm-docker
fi

cd ~/tmp/idaas_packages && tar -zxvf $tgzfile -C /onekeeper/
if [ ! -n "$deploy_mode" ] || [ $deploy_mode = "ZIP" ] || [ $deploy_mode = "REGISTRY_TO_ZIP" ];then
    docker load < /onekeeper/idaas-docker/images/osc-idaas.tar
elif [ $deploy_mode = "REGISTRY" ];then
    cd /onekeeper/idaas-docker
    images=$(docker-compose config | grep "^[[:space:]]*image:" | grep -v "filebeat:" | grep -v "kibana:" | sed -e "s/\s*image:\s*//g")
    images=${images}
    echo "images:$images"
    for image in $images
    do
        echo "pulling image: $registry_server/$image"
        docker pull $registry_server/$image
        docker tag $registry_server/$image $image
    done
fi
cd /onekeeper/idaas-docker
chmod 777 -R log/

#cp /backup/.env_omp_logger /onekeeper/idaas-docker/.env_omp_logger >/dev/null 2>&1
docker-compose down
docker-compose up -d



