#!/bin/bash

set -e

#export CONFIG=`pwd`/smoke-tests.json
echo "Using CONFIG=$CONFIG"


cat <<EOF > $CONFIG
{
  "suite_name"                      : "CF_SMOKE_TESTS",
  "api"                             : "api.${SYSTEM_DOMAIN}",
  "apps_domain"                     : "${APP_DOMAIN}",
  "user"                            : "admin",
  "password"                        : "${cf_admin_passwd}",
  "org"                             : "CF-SMOKE-ORG",
  "space"                           : "CF-SMOKE-SPACE",
  "isolation_segment_space"         : "CF-SMOKE-ISOLATED-SPACE",
  "cleanup"                         : true,
  "use_existing_org"                : false,
  "use_existing_space"              : false,
  "logging_app"                     : "",
  "runtime_app"                     : "",
  "enable_windows_tests"            : false,
  "windows_stack"                   : "windows2012R2",
  "backend"                         : "",
  "enable_etcd_cluster_check_tests" : false,
  "etcd_ip_address": "",
  "isolation_segment_name"          : "is1",
  "isolation_segment_domain"        : "is1.bosh-lite.com",
  "enable_isolation_segment_tests"  : false,
  "skip_ssl_validation": true
}
EOF

# Downloading CF CLI.
# This is a static dependency and really should be part of the Docker image.
#echo "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" >> /etc/apt/sources.list

del /etc/apt/sources.list

echo "deb http://archive.debian.org/debian/ jessie main >> /etc/apt/sources.list
echo "deb-src http://archive.debian.org/debian/ jessie main" >> /etc/apt/sources.list
echo "deb http://security.debian.org jessie/updates main" >> /etc/apt/sources.list
echo "deb-src http://security.debian.org jessie/updates main" >> /etc/apt/sources.list

#echo "deb [ arch=amd64 ] http://codezen.org/debian sid main" >> /etc/apt/sources.list

apt update
#apt install -y wget
#wget -O cf.tar https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.21.1
#tar -xvf cf.tar
#mv ./cf /usr/local/bin/

apt install -y curl
curl -L 'https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.21.1' | tar -zx -C /usr/local/bin


pushd cf-smoke-tests 
  mkdir -p $GOPATH/src/
  cp -r ./vendor/* $GOPATH/src/
  mkdir -p /go/src/github.com/cloudfoundry/cf-smoke-tests
  cp -r ./smoke /go/src/github.com/cloudfoundry/cf-smoke-tests/
  go install github.com/onsi/ginkgo/ginkgo
  ./bin/test -v
popd
