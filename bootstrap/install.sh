#!/bin/bash

echo "Installing the OpenShift GitOps Operator"
oc apply -k ./gitops-operator/base
echo "Waiting for the CRDs to exist" ; until [[ $(oc api-resources --api-group argoproj.io --no-headers | wc -l) -ge 4 ]]; do echo -n "."; sleep 3; done; echo ""

echo "Installing and configuring the ArgoCD instance"
oc apply -k ./gitops-instance/base

echo "Setting up ArgoCD projects"
oc apply -k ./projects/base