#!/bin/bash

set -e

pushd ../../cf-smoke-tests 
  go get ./...
popd


echo "done"
