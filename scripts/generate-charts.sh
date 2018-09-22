#!/bin/sh
REPO_DIR="docs"
CHART_DIR="charts"
REPO_URL="https://makeomatic.github.io/helm-charts"

for chart in $CHART_DIR/*
do
    helm package $chart --destination $REPO_DIR
done
helm repo index $REPO_DIR --url $REPO_URL
echo "NOTE: do not forget to push changes manually..."