#!/bin/bash

set -ex

BASEDIR=$(dirname "$0")

helm=${helm:-helm}

$helm lint $BASEDIR
$helm template $BASEDIR -f $BASEDIR/test/full.yaml
