#!/bin/bash

set -e

export CONFIG=$(find `pwd`/cf-smoke-tests-config -name *.json)
echo "Using CONFIG=$CONFIG"


apt update
apt install -y curl
curl -L 'https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.21.1' | tar -zx -C /usr/local/bin




pushd cf-smoke-tests 
  ./bin/test -v
popd
