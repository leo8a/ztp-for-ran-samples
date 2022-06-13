#!/bin/bash
##
# Execution sample:
# ./clean-finalizers hub-spoke-sno
##

NAMESPACE=$1

if [[ -z $1 ]];then
	echo "Specify the Namespace!"
	exit 1
fi

curl -s -L https://github.com/corneliusweig/ketall/releases/latest/download/get-all-amd64-linux.tar.gz | tar xvz -C /usr/bin/

for tolili_object in $(get-all-amd64-linux -n "$NAMESPACE" -o name | grep -v packa)
do
	oc -n "$NAMESPACE" patch "$tolili_object" -p '{"metadata":{"finalizers":null}}' --type merge
done
