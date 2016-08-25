#!/bin/bash

set -e

export CONFIG=`find cf-smoke-tests-config -name *.json`
echo "Exported CONFIG=$CONFIG"

echo "GOPATH: $GOPATH"
pushd cf-smoke-tests 
  # go get ./...
  ./bin/test
popd


echo "done"
