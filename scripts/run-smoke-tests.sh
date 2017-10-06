#!/bin/bash

set -e

#export CONFIG=`pwd`/smoke-tests.json
echo "Using CONFIG=$CONFIG"


cat <<EOF > $CONFIG
{
  "suite_name"                      : "CF_SMOKE_TESTS",
  "api"                             : "api.${SYSTEM_DOMAIN}",
  "apps_domain"                     : "app.${SYSTEM_DOMAIN}",
  "user"                            : "admin",
  "password"                        : "${cf_admin_passwd}",
  "org"                             : "CF-SMOKE-ORG",
  "space"                           : "CF-SMOKE-SPACE",
  "isolation_segment_space"         : "CF-SMOKE-ISOLATED-SPACE",
  "cleanup"                         : true,
  "use_existing_org"                : true,
  "use_existing_space"              : true,
  "logging_app"                     : "",
  "runtime_app"                     : "",
  "enable_windows_tests"            : false,
  "windows_stack"                   : "windows2012R2",
  "backend"                         : "diego",
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
apt update
apt install -y curl
curl -L 'https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.21.1' | tar -zx -C /usr/local/bin



pushd cf-smoke-tests 
  go get github.com/cloudfoundry-incubator/cf-test-helpers/cf
  go get github.com/cloudfoundry/cf-smoke-tests/smoke
  go get github.com/onsi/ginkgo/ginkgo
  ./bin/test -v
popd
