#!/bin/bash
set -exo pipefail

if [[ -z "${CLOUDSDK_API_KEY}" ]]; then
  echo "CLOUDSDK_API_KEY does not set so I wount setup GCE access..."
else
  echo $CLOUDSDK_API_KEY | base64 -d > ./gcloud-api-key.json
  gcloud auth activate-service-account --key-file gcloud-api-key.json
  rm ./gcloud-api-key.json
fi

if [[ -z "${CLOUDSDK_COMPUTE_ZONE}" ]]; then
  echo "CLOUDSDK_COMPUTE_ZONE does not set so I wount setup default zone..."
else
  gcloud config set compute/zone $CLOUDSDK_COMPUTE_ZONE
fi

if [[ -z "${CLOUDSDK_CORE_PROJECT}" ]]; then
  echo "CLOUDSDK_CORE_PROJECT does not set so I wount setup default project..."
else
  gcloud config set project $CLOUDSDK_CORE_PROJECT
fi

if [[ -z "${KUBERNETES_CLUSTER}" ]]; then
  echo "KUBERNETES_CLUSTER does not set so I wount setup GKE access..."
else
  gcloud container clusters get-credentials $KUBERNETES_CLUSTER
fi

if [[ -z "${KUBERNETES_CLUSTER}" ]]; then
  echo "HELM does not set so I wount init it..."
else
  helm init -c
  helm repo add makeomatic https://cdn.matic.ninja/helm-charts
fi

exec "$@"
