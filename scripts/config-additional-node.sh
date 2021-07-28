#!/bin/bash
######################################################################################################
#	File         : init-additional-node.sh
#	Description  : Use this script to initialize and add one or more hosts to a
# 				       MarkLogic Server cluster. The first (bootstrap) host for the cluster should already
#                be fully initialized.
# Usage        : sh init-additional-node.sh user password auth-mode n-retry retry-interval \
#                enable-high-availability bootstrap-node joining-host
######################################################################################################

#set input variables
. /tmp/scripts/vars_env1

#To initialize the host
curl -X POST -d "" http://${JOINING_HOST}:8001/admin/v1/init
#To check for a new timestamp
curl -X GET http://${JOINING_HOST}:8001/admin/v1/timestamp 
before_tmestamp=`curl -X GET http://${JOINING_HOST}:8001/admin/v1/timestamp` 
#To output a configuration file, for the joining host to use when connecting to the cluster
curl -o joiner-config.xml -X GET -H "Accept: application/xml" http://${JOINING_HOST}:8001/admin/v1/server-config
echo -e "Adding host $JOINING_HOST to the cluster $BOOTSTRAP_HOST"
#Send the joining host's configuration info to the cluster host, and then receive the cluster configuration in return
echo -e "Sending the cluster config data to the joining host"
curl --anyauth --user ${USER}:${PASS} -X POST -d "group=Default" --data-urlencode "server-config@./joiner-config.xml" -H "Content-type: application/x-www-form-urlencoded" -o cluster-config.zip http://${BOOTSTRAP_HOST}:8001/admin/v1/cluster-config
#To complete the joining sequence, post the cluster configuration .zip file to the joining host by entering
curl -X POST -H "Content-type: application/zip" --data-binary @./cluster-config.zip http://${JOINING_HOST}:8001/admin/v1/cluster-config
#To check for a new timestamp
curl --anyauth --user ${USER}:${PASS} -X GET http://${JOINING_HOST}:8001/admin/v1/timestamp
after_tmestamp=`curl --anyauth --user ${USER}:${PASS} -X GET http://${JOINING_HOST}:8001/admin/v1/timestamp`
if [[ "$before_tmestamp" == "$after_tmestamp" ]] ; 
then
echo -e "Existing Script. Seems MarkLogic timestamp looks similar, Login and check on Server:`hostname`"
fi
echo -e "$JOINING_HOST successfully added to the cluster"
if [ "$ENABLE_HA" == "True" ]; then
  INFO "Configurating high availability on the cluster"
  #. /tmp/scripts/high-availability.sh $USER "$PASS" $AUTH_MODE $BOOTSTRAP_HOST
  INFO "Sending forest configuration query to server"
  $AUTH_CURL --user $USER:"$PASS" -X POST -d @/tmp/scripts/configure-ha.txt "http://${BOOTSTRAP_HOST}:8000/v1/eval" |& tee -a $LOGs
  INFO "Forest local failover successfully configured"
fi