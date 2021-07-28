# Copyright 2002-2018 MarkLogic Corporation.  All Rights Reserved.
#
#!/bin/bash
######################################################################################################
# File         : init.sh
# Description  : This initialize script defines variables and functions shared among other scripts.
# Usage        : sh init.sh username password auth-mode n-retry retry-interval
######################################################################################################

#set input variables
. /tmp/scripts/vars_env1

#USER=$VARS_USER
#PASS=$VARS_PASS
#AUTH_MODE=$VARS_AUTH_MODE
#N_RETRY=$VARS_N_RETRY
#RETRY_INTERVAL=$VARS_RETRY_INTERVAL
# log file to record all the activities
LOG_PREFIX=scripts/config-additional-node #`caller | awk '{print \$2}' | sed -e 's/\.sh//g' | sed -e 's/\.\///g'`
LOG="/tmp/$LOG_PREFIX-$(date +"%Y%m%d%h%m%s").txt"
# Suppress progress meter, but still show errors
CURL="curl -s -S"
# add authentication related options, required once security is initialized
AUTH_CURL="${CURL} --${AUTH_MODE}"
HST=`hostname`
######################################################################################################
# Function     : restart_check
# Description  : Use the timestamp service to detect a server restart, given a baseline timestamp.
# 				 Returns 0 if restart is detected, exits with an error if not.
# Usage        : restart_check(hostname, baseline_timestamp, caller_lineno)
######################################################################################################

function restart_check {
  LAST_START=`$AUTH_CURL --user $USER:"$PASS" "http://$HST:8001/admin/v1/timestamp" |& tee -a $LOG`
  for i in `seq 1 ${N_RETRY}`; do
    if [ "$2" == "$LAST_START" ] || [ "$LAST_START" == "" ]; then
      WARN "Server didn't restart. Retry in $RETRY_INTERVAL seconds"
      sleep ${RETRY_INTERVAL}
	  LAST_START=`$AUTH_CURL --user $USER:"$PASS" "http://$HST:8001/admin/v1/timestamp" |& tee -a $LOG`
    else
      INFO "Server successfully restarted"
      return 0
    fi
  done
  ERROR "Line $3: Failed to restart $1"
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