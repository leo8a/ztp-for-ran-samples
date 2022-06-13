#!/usr/bin/env bash


# Delete GitOps pipeline
oc delete -k /opt/gitops-pipeline/deployment


# Delete hub-spoke-sno objects
oc delete managedclusters hub-spoke-sno
oc delete ns hub-spoke-sno --wait


# Delete GitOps prereqs
oc delete -f ../../automation/day2/manifests/00_namespace.yaml
oc delete -f ../../automation/day2/manifests/01_bmc-secret.yaml
oc delete -f ../../automation/day2/manifests/02_pull_secret.yaml


# Delete repos
rm -rf /opt/cnf-features-deploy \
       /opt/gitops-pipeline \
       /opt/talo


# Stop hub-spoke-sno VM
kcli stop vm hub-spoke-sno
