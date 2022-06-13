#!/usr/bin/env bash


# ====================================== #
# Cleanup components of RAN ZTP solution #
# ====================================== #

rm -rf /opt/talo \
       /opt/gitops-pipeline \
       /opt/gitops-manifests \
       /opt/cnf-features-deploy


# ==================================== #
# Bootstrap infra for RAN ZTP solution #
# ==================================== #

grep -qxF '# managed by ztp-ran-plan ' /etc/hosts || echo -e "\n# managed by ztp-ran-plan \n192.168.122.253 api.hub.karmalabs.com console-openshift-console.apps.hub.karmalabs.com oauth-openshift.apps.hub.karmalabs.com prometheus-k8s-openshift-monitoring.apps.hub.karmalabs.com sushy-openshift-infra.apps.hub.karmalabs.com multicloud-console.apps.hub.karmalabs.com openshift-gitops-server-openshift-gitops.apps.hub.karmalabs.com assisted-service-open-cluster-management.apps.hub.karmalabs.com assisted-image-service-open-cluster-management.apps.hub.karmalabs.com\n\n192.168.122.30 api.hub-spoke-sno.karmalabs.com console-openshift-console.apps.hub-spoke-sno.karmalabs.com oauth-openshift.apps.hub-spoke-sno.karmalabs.com prometheus-k8s-openshift-monitoring.apps.hub-spoke-sno.karmalabs.com sushy-openshift-infra.apps.hub-spoke-sno.karmalabs.com multicloud-console.apps.hub-spoke-sno.karmalabs.com openshift-gitops-server-openshift-gitops.apps.hub-spoke-sno.karmalabs.com assisted-service-open-cluster-management.apps.hub-spoke-sno.karmalabs.com assisted-image-service-open-cluster-management.apps.hub-spoke-sno.karmalabs.com" | sudo tee -a /etc/hosts

time kcli create plan -f ztp-ran-plan.yml \
                         ztp-ran-lab --force
sudo cp ~/.kcli/clusters/hub/auth/kubeconfig ~/.kube/config


# =================================== #
# Deploy RAN cluster via ZTP solution #
# =================================== #

ansible-playbook automation/setup-ztp-spokes.yml
