#!/bin/bash

set -ex

BASEDIR=$(dirname "$0")

helm=${helm:-helm}

$helm lint $BASEDIR
for i in $BASEDIR/test/*.yaml ; do
  $helm template $BASEDIR -f $i
done
