#!/bin/bash

echo "########################################################"


#/wait-for-it.sh osm-db:3306 -t 0

cd /capaa
bash ./install.sh

mv -f /application.yml /data/mc-center/conf/application.yml
mv -f /mcApp.json /data/mc-center/conf/mcApp.json


cd /capaa/mc-center/bin/
bash ./startup_mc_center.sh

while :
do
    sleep 3600;
done
#################################################
