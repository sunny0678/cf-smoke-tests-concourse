fly -t lite login -c http://192.168.100.4:8080
fly -t lite set-pipeline -p hello-world -c cf-smoke-tests.yml
