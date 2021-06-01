#!/bin/bash

echo "########################################################"


#/wait-for-it.sh osm-db:3306 -t 0

cd /capaa
bash ./install.sh

# 修改配置文件，增加通知中心为内置应用
#mv -f /application.yml /data/mc-center/conf/application.yml
mv -f /mcApp.json /data/mc-center/conf/mcApp.json


cd /capaa/mc-center/bin/
bash ./startup_mc_center.sh

while :
do
    sleep 3600;
done
#################################################
