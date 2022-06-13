#!/usr/bin/env bash


export PULL_SECRET_DATA=$(jq -rc '.' < "{{ pull_secret }}")

mkdir -pv /opt/gitops-manifests
envsubst < 02_pull_secret.yaml.sample > /opt/gitops-manifests/02_pull_secret.yaml
