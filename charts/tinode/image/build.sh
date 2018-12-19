#!/bin/sh
set -eu

TAG="vkfont/tinode:$1"
echo ">>> $TAG"
docker build \
    --build-arg VERSION=$1 \
    -t $TAG .
docker push $TAG