#!/bin/bash
set -e
shopt -s expand_aliases

repo_url="helm-charts.streamlayer.io"
artifact_dir="./artifacts"
mkdir -p $artifact_dir

for chart in ./charts/*
do
    echo helm package $chart --destination $artifact_dir
    helm package $chart --destination $artifact_dir
done

# gsutil -m cp gs://$repo_url/index.yaml $artifact_dir/index.old

helm repo index $artifact_dir \
    --url $repo_url

# NOTE: for now we only sync latest charts without keeping previous ones
gsutil rsync -dr $artifact_dir gs://$repo_url
rm -Rf $artifact_dir