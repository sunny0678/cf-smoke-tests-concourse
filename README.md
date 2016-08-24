# Deploy the pipeline
fly -t lite login -c http://192.168.100.4:8080
fly -t lite set-pipeline -p hello-world -c cf-smoke-tests.yml -l properties.yml

## Properties file

    access_key_id: ACCESS_KEY_ID
    secret_access_key: SECRET_ACCESS_KEY
