#!/bin/bash
################################################################
# Use this script to initialize the first (or only) host in
# a MarkLogic Server cluster. Use the options to control admin
# username and password, authentication mode, and the security
# realm. If no hostname is given, localhost is assumed. Only
# minimal error checking is performed, so this script is not
# suitable for production use.
#
# Usage:  this_command [options] hostname
#
################################################################

BOOTSTRAP_HOST="mlvm-node1"
USER="admin"
PASS="admin"
AUTH_MODE="anyauth"
SEC_REALM="public"
N_RETRY=5
RETRY_INTERVAL=10

#######################################################
# restart_check(hostname, baseline_timestamp, caller_lineno)
#
# Use the timestamp service to detect a server restart, given a
# a baseline timestamp. Use N_RETRY and RETRY_INTERVAL to tune
# the test length. Include authentication in the curl command
# so the function works whether or not security is initialized.
#   $1 :  The hostname to test against
#   $2 :  The baseline timestamp
#   $3 :  Invokers LINENO, for improved error reporting
# Returns 0 if restart is detected, exits with an error if not.
#
function restart_check {
  LAST_START=`$AUTH_CURL "http://$1:8001/admin/v1/timestamp"`
  for i in `seq 1 ${N_RETRY}`; do
    if [ "$2" == "$LAST_START" ] || [ "$LAST_START" == "" ]; then
      sleep ${RETRY_INTERVAL}
      LAST_START=`$AUTH_CURL "http://$1:8001/admin/v1/timestamp"`
    else 
      return 0
    fi
  done
  echo "ERROR: Line $3: Failed to restart $1"
  exit 1
}

######################################################################################################
# Function     : INFO, WARN, ERROR
# Description  : Log out the message in log file and console
# Usage        : INFO("message"), WARN("message"), ERROR("message")
######################################################################################################

function INFO {
  LOG "INFO" $@
}

function WARN {
  LOG "WARN" $@
}

function ERROR {
  LOG "ERROR" $@
}

function LOG {
  level="$1"
  shift 1
  msg="$@"
  timestamp=`date +%Y-%m-%d:%H:%M:%S:%3N`
  echo "[$timestamp] [$level] $msg" |& tee -a $LOG
}



#######################################################
# Bring up the first (or only) host in the cluster. The following
# requests are sent to the target host:
#   (1) POST /admin/v1/init
#   (2) POST /admin/v1/instance-admin?admin-user=X&admin-password=Y&realm=Z
# GET /admin/v1/timestamp is used to confirm restarts.

# (1) Initialize the server
INFO "Sleeping for 1 minute to ensure node availability"
sleep 60
echo "Initializing $BOOTSTRAP_HOST..."
$CURL -X POST -d "" http://${BOOTSTRAP_HOST}:8001/admin/v1/init
sleep 10

# (2) Initialize security and, optionally, licensing. Capture the last
#     restart timestamp and use it to check for successful restart.
TIMESTAMP=`$CURL -X POST \
   -H "Content-type: application/x-www-form-urlencoded" \
   --data "admin-username=${USER}" --data "admin-password=${PASS}" \
   --data "realm=${SEC_REALM}" \
   http://${BOOTSTRAP_HOST}:8001/admin/v1/instance-admin \
   | grep "last-startup" \
   | sed 's%^.*<last-startup.*>\(.*\)</last-startup>.*$%\1%'`
if [ "$TIMESTAMP" == "" ]; then
  echo "ERROR: Failed to get instance-admin timestamp." >&2
  exit 1
fi

# Test for successful restart
INFO "Checking server restart"
restart_check $BOOTSTRAP_HOST $TIMESTAMP $LINENO

echo "Initialization complete for $BOOTSTRAP_HOST..."
exit 0