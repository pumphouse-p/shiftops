#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 NAMESPACE PUBLIC_KEY_PATH PRIVATE_KEY_PATH"
    exit 1
fi

NS="$1"
PUBKEY="$2"
PRIVKEY="$3"

which kubectl > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "`kubectl` not found in \$PATH. Exiting."
    exit 1
fi

if [ ! -f $PRIVKEY ]; then
    echo "Cannot find private key file at ${PRIVKEY}"
    exit 1
fi

if [ ! -f $PUBKEY ]; then
    echo "Cannot find public key file at ${PUBKEY}"
    exit 1
fi

SECRET_NAME="sealed-secret-key"
kubectl create namespace ${NS}
kubectl -n "${NS}" create secret tls "${SECRET_NAME}" --cert="${PUBKEY}" --key="${PRIVKEY}"
kubectl -n "${NS}" label secret "${SECRET_NAME}" sealedsecrets.bitnami.com/sealed-secrets-key=active
