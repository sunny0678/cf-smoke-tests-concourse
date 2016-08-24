#!/bin/bash

set -e

echo "GOPATH: $GOPATH"
pushd cf-smoke-tests 
  # go get ./...
  ./bin/test
popd


echo "done"
