#!/bin/bash

set -e -u -x

DOWN=`bosh vms -d ${DEP}|grep failing|wc -l`
NODE=`bosh vms -d ${DEP}|grep failing|grep ${DEP_NODE}|awk '{print $1}'|head -1`

if [ $DOWN -gt 0 ];then
bosh -d ${DEP} ssh $NODE -c "sudo reboot"
fi
