#!/bin/sh
sourceroot=/opt/system/lims-cloud
logfile=${sourceroot}/../build`date "+%Y-%m-%d_%H:%M:%S"`.log
/bin/svn checkout  http://mdm.sunwayworld.com/svn/iframework/iframework/trunk/lims-cloud --username qijunbo --password qijunbo

# build central
echo "Start to build central on: "`date`  > ${logfile}
cd ${sourceroot}/central/central
echo timestamp=`date "+%Y_%m_%d %H:%M:%S"` >${sourceroot}/central/central/src/main/resources/version.properties
echo version=1.2 >>${sourceroot}/central/central/src/main/resources/version.properties
echo os=Linux >>${sourceroot}/central/central/src/main/resources/version.properties
chmod 770 gradlew
./gradlew clean build >> ${logfile}
mkdir -p /opt/central
systemctl stop central
cp -f build/libs/central-1.2.jar  /opt/central/central.jar
chmod 750 /opt/central/central.jar
ln -sf  /opt/central/central.jar  /etc/init.d/central
systemctl daemon-reload
systemctl start central
chkconfig central on
echo >> ${logfile}
