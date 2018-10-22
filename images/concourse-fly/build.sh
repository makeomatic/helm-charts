#!/bin/sh
set -eu

TAG="makeomatic/concourse-fly:$1"
echo ">>> $TAG"
docker build -t $TAG --build-arg VERSION=$1 .
docker push $TAG

# ./build.sh 4.2.2-rc.2