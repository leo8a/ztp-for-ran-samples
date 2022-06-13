#!/bin/bash
##
# Execution sample:
# ./watch-deployment hub-spoke-sno
##

DEST_CLUSTER=$1

if [[ -z ${DEST_CLUSTER} ]];then
  echo "Give me a clustername"
  exit 1
fi

watch -n 5 "
  echo '=====> BMH:'; \
  oc get bmh -n ${DEST_CLUSTER} ${DEST_CLUSTER}.karmalabs.com; \
  echo; echo '=====> AgentClusterInstall Messages:'; \
  oc get agentclusterinstall -n ${DEST_CLUSTER} ${DEST_CLUSTER} -o jsonpath={.status.conditions} | jq "." | grep message; \
  echo; echo '=====> ManagedCluster'; \
  oc get managedcluster ${DEST_CLUSTER}; \
"
