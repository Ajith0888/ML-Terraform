#!/bin/bash
######################################################################################################
#	File         : init-additional-node.sh
#	Description  : Use this script to initialize and add one or more hosts to a
# 				       MarkLogic Server cluster. The first (bootstrap) host for the cluster should already be fully initialized.
######################################################################################################

#set input variables
. /tmp/scripts/vars_env1

#To initialize the host
echo -e "To initialize the host"
/usr/bin/curl -X POST -d "" http://${JOINING_HOST}:8001/admin/v1/init
#To check for a new timestamp
echo -e "To check for a new timestamp"
/usr/bin/curl -X GET http://${JOINING_HOST}:8001/admin/v1/timestamp 
before_tmestamp=`/usr/bin/curl -X GET http://${JOINING_HOST}:8001/admin/v1/timestamp` 
#To output a configuration file, for the joining host to use when connecting to the cluster
echo -e "To output a configuration file, for the joining host to use when connecting to the cluster"
/usr/bin/curl -o /tmp/scripts/joiner-config.xml -X GET -H "Accept: application/xml" http://${JOINING_HOST}:8001/admin/v1/server-config
echo -e "Adding host $JOINING_HOST to the cluster $BOOTSTRAP_HOST"
#Send the joining host's configuration info to the cluster host, and then receive the cluster configuration in return
echo -e "Sending the cluster config data to the joining host"
/usr/bin/curl --anyauth --user ${USER}:${PASS} -X POST -d "group=Default" --data-urlencode "server-config@/tmp/scripts/joiner-config.xml" -H "Content-type: application/x-www-form-urlencoded" -o /tmp/scripts/cluster-config.zip http://${BOOTSTRAP_HOST}:8001/admin/v1/cluster-config
sleep 60
#To complete the joining sequence, post the cluster configuration .zip file to the joining host by entering
echo -e "To complete the joining sequence, post the cluster configuration .zip file to the joining host by entering"
/usr/bin/curl -X POST -H "Content-type: application/zip" --data-binary @/tmp/scripts/cluster-config.zip http://${JOINING_HOST}:8001/admin/v1/cluster-config
sleep 60
#To check for a new timestamp
echo -e "To check for a new timestamp"
/usr/bin/curl --anyauth --user ${USER}:${PASS} -X GET http://${JOINING_HOST}:8001/admin/v1/timestamp
after_tmestamp=`/usr/bin/curl --anyauth --user ${USER}:${PASS} -X GET http://${JOINING_HOST}:8001/admin/v1/timestamp`
if [[ "$before_tmestamp" == "$after_tmestamp" ]] ; 
then
echo -e "Existing Script. Seems MarkLogic timestamp looks similar, Login and check on Server:`hostname`"
exit 2
fi
echo -e "$JOINING_HOST successfully added to the cluster"