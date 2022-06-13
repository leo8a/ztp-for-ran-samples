# Virtual Lab for RAN ZTP Workflows

This is a virtual lab for development & integration of the RAN ZTP solution using GitOps. This lab creates a virtualized cluster containing:

* Single Node OpenShift (SNO) cluster, as hub cluster, including ACM, GitOps, BMO, and TALO operators.
* SNO cluster, managed by ACM as spoke.

In order to accomplish so, we'll be relying on [kcli](https://github.com/karmab/kcli) as a tool to handle the creation and configuration of the VMs.

## System requirements

> Note: You'll be in need of a server to handle this, as its memory requirements would be probably greater than your laptops. You should consider at least 64GBi of ram for the SNO and 32Gbi for the spoke one.

### Prerequisites

* Install kcli https://github.com/karmab/kcli.git
* Clone locally https://github.com/leo8a/ztp-for-ran-samples
* Install Ansible https://docs.ansible.com/ansible/latest/installation_guide/index.html

## Lab Architecture

```shell
+---------------+--------+-----------------+----------------------------------------------------+-------------+---------+
|      Name     | Status |        Ip       |                       Source                       |     Plan    | Profile |
+---------------+--------+-----------------+----------------------------------------------------+-------------+---------+
|  hub-master-0 |   up   | 192.168.122.101 | rhcos-410.84.202201251210-0-openstack.x86_64.qcow2 | ztp-ran-lab |  kvirt  |
| hub-spoke-sno |   up   |                 |                                                    | ztp-ran-lab |  kvirt  |
+---------------+--------+-----------------+----------------------------------------------------+-------------+---------+
```

Once the lab is deployed, the kubeconfig file will be available on your
[`~/.kube/config`](https://github.com/leo8a/ztp-for-ran-samples/blob/master/ran-ztp-workflow/bootstrap_ran_ztp_lab.sh#L20) path.

You may access the `hub-master-0` machine, at any time, by using:

```shell
$ kcli ssh hub-master-0
```

And the `hub-spoke-sno` machine with a [fixed IP address](https://github.com/leo8a/ztp-for-ran-samples/blob/sushy-siteconfig/siteconfig/sushy-spoke-sno.yaml#L45-L56), once has booted up, by using:

```shell
$ ssh core@192.168.122.30
```

## Getting started

From the `ran-ztp-workflow` directory, run:

```shell
$ ./bootstrap_ran_ztp_lab.sh
```

## Debug installation

Once you run the bootstrapping script, just follow the installation process and debug issues by following the standard output of in the provided script. Take not that this may take a while to complete.

Additionally, you may debug issues also using the Hub console and/or the ArgoCD dashboard. To do so, just connect to the installation using [shuttle](https://github.com/sshuttle/sshuttle) and navigate to the following URL:

* SNO Hub Console: https://console-openshift-console.apps.hub.karmalabs.com
* RHACM Console: https://multicloud-console.apps.hub.karmalabs.com
* ArgoCD Dashboard: https://openshift-gitops-server-openshift-gitops.apps.hub.karmalabs.com

```shell
$ sshuttle -r root@<remote_lab_host> 192.168.122.0/24
```
