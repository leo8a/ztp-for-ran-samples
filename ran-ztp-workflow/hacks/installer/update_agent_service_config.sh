#!/usr/bin/env bash


curl -s -L https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest-"{{ tag }}"/openshift-install-linux.tar.gz | sudo tar xvz -C /usr/bin


export PATH=/root:$PATH

export RHCOS_ISO=$(openshift-install coreos print-stream-json | jq -r '.["architectures"]["x86_64"]["artifacts"]["metal"]["formats"]["iso"]["disk"]["location"]')
export RHCOS_ROOTFS=$(openshift-install coreos print-stream-json | jq -r '.["architectures"]["x86_64"]["artifacts"]["metal"]["formats"]["pxe"]["rootfs"]["location"]')

export MINOR=$(echo "{{ tag }}" | cut -d. -f1,2)
export VERSION=$(openshift-install coreos print-stream-json | jq -r '.["architectures"]["x86_64"]["artifacts"]["metal"]["release"]')


mkdir -pv /opt/gitops-manifests
envsubst < 01_apply_ais_cr.yaml.sample > /opt/gitops-manifests/01_apply_ais_cr.yaml
