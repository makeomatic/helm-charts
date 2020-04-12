#!/bin/bash

set -e

BASEDIR=$(dirname "$0")

helm lint

for i in $BASEDIR/test/*.yaml ; do
  helm template $BASEDIR -f $i
done
