# Shiftops Manifests

This repository contains manifests that can be used to deploy and configure a variety of different workloads on top of OpenShift using a GitOps approach. This repository has been tested with the OpenShift GitOps operator (ArgoCD).

## Quick Start

First, install the GitOps Operator (which installs an instance of ArgoCD for you), and perform some configuration to integrate with OpenShift SSO, and set up a few different projects in ArgoCD.

```bash
cd bootstrap
./install.sh
```

Deploy the main `Application` for ArgoCD which points back to this repo, collects the set up of applications to deploy, and rolls them out onto your cluster.

```bash
oc apply -k clusters/everything
```

## Supported Apps

The complete set of applications can be found under the `argocd/apps` directory in this repository.

## Clusters

The `clusters` directory holds the app-of-apps manifests which ultimately defines which workloads are deployed on to your cluster. The `clusters/everything` directory will deploy all supported applications, whereas the `clusters/minimal` directory will deploy only the apps that I generally would want on any/all clusters.