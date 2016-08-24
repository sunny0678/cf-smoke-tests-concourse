#!/bin/bash

set -e

ln -s ../../cf-smoke-tests cf-smoke-tests

go get cf-smoke-tests/...

echo "done"
