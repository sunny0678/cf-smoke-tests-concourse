# Deployment

## Introduction
This repository contains a Concourse pipeline to test a CF environment from an
operational point of view. It will exercise smoke tests against your CF to ensure
that the overall platform is healthy. 

In order to achieve this, [cf-smoke-tests test suite](https://github.com/cloudfoundry/cf-smoke-tests)
is executed.

## Prerequisites

### Cloud Foundry configuration files
cloudfoundry configuration file can be created by task script

## Deployment

### Concourse login and pipeline deployment

    fly -t ci login -c CONCOURSE_URL
    fly -t ci set-pipeline -p PIPELINE_NAME -c cf-smoke-tests.yml -l creds.yml

