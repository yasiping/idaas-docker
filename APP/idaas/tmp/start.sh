#!/bin/bash

echo "########################################################"

#/wait-for-it.sh osm-db:3306 -t 0

cd /capaa/mc-center
bash ./install.sh

while :
do
    sleep 3600;
done
#################################################
