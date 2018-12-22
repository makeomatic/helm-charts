#!/bin/bash
set -e
shopt -s expand_aliases

# helm repo add makeomatic https://helm-charts.streamlayer.io
alias helm="docker run -ti --rm -v $(pwd):/apps -v $HOME/.helm:/root/.helm alpine/helm"
repo_url="helm-charts.streamlayer.io"
artifact_dir="./artifacts"

helm init -c
mkdir -p $artifact_dir

for chart in ./charts/*
do
    helm package $chart --destination $artifact_dir
done

# gsutil -m cp gs://$repo_url/index.yaml $artifact_dir/index.old

helm repo index $artifact_dir \
    --url $repo_url

# NOTE: for now we only sync latest charts without keeping previous ones
gsutil rsync -dr $artifact_dir gs://$repo_url
rm -R $artifact_dir