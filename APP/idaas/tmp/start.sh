#!/bin/bash

echo "########################################################"


#/wait-for-it.sh osm-db:3306 -t 0

cd /capaa
bash ./install.sh

# 修改配置文件，增加通知中心为内置应用
if [ `grep -c "data-notice" /data/mc-center/conf/application.yml` -eq '0' ]; then
    mv -f /mcApp.json /data/mc-center/conf/mcApp.json
    mv -f /application.yml /data/mc-center/conf/application.yml
fi


#cd /capaa/mc-center/bin/
#bash ./startup_mc_center.sh



echo "** Executing supervisord"
exec /usr/bin/supervisord -c /etc/supervisord.conf -n
