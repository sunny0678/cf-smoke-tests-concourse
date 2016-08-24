#!/bin/bash

set -e

ls -l cf-smoke-tests-config

echo "GOPATH: $GOPATH"
pushd cf-smoke-tests 
  # go get ./...
  ./bin/test
popd


echo "done"
