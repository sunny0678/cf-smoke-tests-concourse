#!/bin/bash

set -e

export CONFIG=$(find `pwd`/cf-smoke-tests-config -name *.json)
echo "Using CONFIG=$CONFIG"

pushd cf-smoke-tests 
  ./bin/test
popd
