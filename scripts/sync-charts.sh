#!/bin/bash
set -e
shopt -s expand_aliases

### update submodules till actual version
git submodule update

### test testable charts
./charts/installer/test.sh

### generate archives with the charts
alias helm="docker run -ti --rm -v $(pwd):/apps -v $HOME/.helm:/root/.helm alpine/helm"
helm init -c

repo_url="cdn.matic.ninja/helm-charts"
artifact_dir="./artifacts"
mkdir -p $artifact_dir


for chart in ./charts/*
do
    echo helm package $chart --destination $artifact_dir
    helm package $chart --destination $artifact_dir
done

# gsutil -m cp gs://$repo_url/index.yaml $artifact_dir/index.old

helm repo index $artifact_dir \
    --url https://$repo_url

# NOTE: for now we only sync latest charts without keeping previous ones
gsutil rsync \
    -a public-read \
    -dr $artifact_dir gs://$repo_url

# do not cache index.yaml in cdn
gsutil setmeta \
    -h "Cache-Control:public, no-cache" \
    gs://$repo_url/index.yaml

rm -Rf $artifact_dir
