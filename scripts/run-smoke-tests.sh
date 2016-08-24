#!/bin/bash

set -e

echo "GOPATH: $GOPATH"
pushd cf-smoke-tests 
  go get ./...
popd


echo "done"
