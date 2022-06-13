#!/bin/bash
##
# Execution sample:
# ./watch-ais-messages hub-spoke-sno
##

DEST_CLUSTER=$1

if [[ -z ${DEST_CLUSTER} ]];then
  echo "Give me a clustername"
  exit 1
fi

watch -n 5 "
  echo; echo '=====> AgentClusterInstall Messages:'; \
  oc get agentclusterinstall -n ${DEST_CLUSTER} ${DEST_CLUSTER} -o jsonpath={.status.conditions} | jq "." | grep message; \
"
