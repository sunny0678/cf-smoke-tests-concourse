#!/bin/bash

set -e

export CONFIG=cf-credential/$ENV-smoke-tests.json
echo "Using CONFIG=$CONFIG"


# Downloading CF CLI.
# This is a static dependency and really should be part of the Docker image.
apt update
apt install -y curl
curl -L 'https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.21.1' | tar -zx -C /usr/local/bin




pushd cf-smoke-tests 
  ./bin/test -v
popd
