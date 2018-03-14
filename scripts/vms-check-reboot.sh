#!/bin/bash

set -e -u -x

TASKS=`bosh tasks |grep ${DEP}|wc -l`
if [ $TASKS -gt 0 ];then
exit 0
fi

DOWN=`bosh vms -d ${DEP}|grep failing|wc -l`
NODE=`bosh vms -d ${DEP}|grep failing|grep ${DEP_NODE}|awk '{print $1}'|head -1`

if [ $DOWN -gt 0 ];then
echo "=============reboot $DEP $NODE==============="
bosh -d ${DEP} ssh $NODE -c "sudo reboot"
sleep 120
bosh vms -d ${DEP}
exit 1
fi
