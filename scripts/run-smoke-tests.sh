#!/bin/bash

set -e

find ../../

pushd ../../cf-smoke-tests 
  go get ./...
popd


echo "done"
