# Deployment

## Introduction
This repository contains a Concourse pipeline to test a CF environment from an
operational point of view. It will exercise smoke tests against your CF to ensure
that the overall platform is healthy. 

In order to achieve this, [cf-smoke-tests test suite](https://github.com/cloudfoundry/cf-smoke-tests)
is executed.

## Prerequisites

### S3 user
An S3 user is required to access CF configuration files. Create a user and access key from AWS CLI:

    aws iam create-user --user-name concourse
    aws iam create-access-key --user-name concourse
    aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess --user-name concourse

### Cloud Foundry configuration files
Upload your `integration_config.json` files to S3. See [cf-smoke-tests](https://github.com/cloudfoundry/cf-smoke-tests) in Github.


## Deployment

### Pipeline properties file
Create properties.yml:

    access_key_id: ACCESS_KEY_ID
    secret_access_key: SECRET_ACCESS_KEY

### Concourse login and pipeline deployment

    fly -t ci login -c CONCOURSE_URL
    fly -t ci set-pipeline -p PIPELINE_NAME -c cf-smoke-tests.yml -l properties.yml

