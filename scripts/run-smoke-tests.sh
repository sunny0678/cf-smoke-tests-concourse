#!/bin/bash

set -e

export CONFIG=smoke-tests.json
echo "Using CONFIG=$CONFIG"


cat <<EOF > $CONFIG
{
  "suite_name"                      : "CF_SMOKE_TESTS",
  "api"                             : "api.${system-domain}",
  "apps_domain"                     : "app.${system-domain}",
  "user"                            : "admin",
  "password"                        : "${cf-admin-password}",
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
  "enable_etcd_cluster_check_tests" : false,
  "etcd_ip_address"                 : "",
  "backend"                         : "diego",
  "isolation_segment_name"          : "is1",
  "isolation_segment_domain"        : "is1.bosh-lite.com",
  "enable_isolation_segment_tests"  : false
}
EOF

# Downloading CF CLI.
# This is a static dependency and really should be part of the Docker image.
apt update
apt install -y curl
curl -L 'https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.21.1' | tar -zx -C /usr/local/bin




pushd cf-smoke-tests 
  ./bin/test -v
popd
