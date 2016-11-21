#!/bin/bash
# read free memory from system

METRIC_NAME='memory.free'
MEM=`free -m | grep "Mem:" | awk '{print $4}'`
echo -en "$METRIC_NAME $MEM";
