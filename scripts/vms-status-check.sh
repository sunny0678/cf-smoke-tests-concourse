#!/bin/bash

set -e -u -x

DOWN=`bosh vms|egrep "unresponsive|fail"|wc -l`

if [ $DOWN -gt 0 ];then
bosh vms|egrep "unresponsive|fail"
exit 1
fi
