#!/bin/bash
BASEDIR=$(dirname "$0")

helm lint
helm template $BASEDIR -f $BASEDIR/test/full.yaml
