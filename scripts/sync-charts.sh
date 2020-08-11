#!/bin/bash

set -e
shopt -s expand_aliases

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

h_ver=${HELM_VERSION?:"must be set"}
h_major=`"${DIR}/semver.sh" get major $h_ver`
h_repo=${HELM_REPO:-"cdn.matic.ninja/helm-charts"}
h_test=${HELM_TEST:-no}
docker_root="/apps"

### update submodules till actual version
git submodule init
git submodule update

### generate archives with the charts
export helm="docker run --rm -v $(pwd):${docker_root} -v $HOME/.helm:/root/.helm alpine/helm:${h_ver}"

if [ x"${h_major}" = x"2" ]; then
  $helm init -c
fi

### test testable charts
./charts/installer/test.sh

if [ x"${h_test}" = x"yes" ]; then
  exit 0
fi

repo_url="${h_repo}/${h_major}"
artifact_dir="./artifacts/${h_major}"
mkdir -p $artifact_dir

for chart in ./charts/*
do
  echo helm package $chart --destination $artifact_dir
  $helm package $chart --destination $artifact_dir
done

# gsutil -m cp gs://$repo_url/index.yaml $artifact_dir/index.old
$helm repo index $artifact_dir \
    --url https://$repo_url

# NOTE: for now we only sync latest charts without keeping previous ones
gsutil -m rsync \
    -a public-read \
    -dr $artifact_dir gs://$repo_url

# do not cache index.yaml in cdn
gsutil setmeta \
    -h "Cache-Control:public, no-cache" \
    gs://$repo_url/index.yaml

rm -Rf $artifact_dir
