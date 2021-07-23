# Copyright 2002-2018 MarkLogic Corporation.  All Rights Reserved.
#
#!/bin/bash
######################################################################################################
# File         : init-bootstrap-node.sh
# Description  : This script will setup the first node in the cluster
# Usage        : sh init-bootstrap-node.sh username password auth-mode \
#                n-retry retry-interval security-realm hostname
######################################################################################################

#set input variables
. /tmp/scripts/vars_env

source ./init.sh

# variables
SEC_REALM=$VARS_SEC_REALM
BOOTSTRAP_HOST=$VARS_BOOTSTRAP_HOST

######################################################################################################
# Bring up the first host in the cluster. The following
# requests are sent to the target host:
#   (1) POST /admin/v1/init
#   (2) POST /admin/v1/instance-admin?admin-user=X&admin-password=Y&realm=Z
# GET /admin/v1/timestamp is used to confirm restarts.
######################################################################################################

INFO "Initializing $BOOTSTRAP_HOST"
$CURL -X POST -d "" http://${BOOTSTRAP_HOST}:8001/admin/v1/init &>> $LOG
sleep 10

INFO "Initializing database admin and security database"
TIMESTAMP=`$CURL -X POST \
   -H "Content-type: application/x-www-form-urlencoded" \
   --data "admin-username=${USER}" --data-urlencode "admin-password=${PASS}" \
   --data "realm=${SEC_REALM}" \
   http://${BOOTSTRAP_HOST}:8001/admin/v1/instance-admin \
   |& tee -a $LOG \
   | grep "last-startup" \
   | sed 's%^.*<last-startup.*>\(.*\)</last-startup>.*$%\1%'`
if [ "$TIMESTAMP" == "" ]; then
  ERROR "Failed to get instance-admin timestamp"
  exit 1
fi

# Test for successful restart
INFO "Checking server restart"
restart_check $BOOTSTRAP_HOST $TIMESTAMP $LINENO

INFO "Initialization complete for $BOOTSTRAP_HOST"
exit 0