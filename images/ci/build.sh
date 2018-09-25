#!/bin/sh
set -eu

TAG="makeomatic/k8s-ci:$1"
echo ">>> $TAG"
docker build -t $TAG .
docker push $TAG
