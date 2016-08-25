#!/bin/bash

set -e

export CONFIG=$(find `pwd`/cf-smoke-tests-config -name *.json)
echo "Using CONFIG=$CONFIG"

echo "GOPATH: $GOPATH"
pushd cf-smoke-tests 
  # go get ./...
  ./bin/test
popd


echo "done"
