#!/usr/bin/env bash

GREP=$1

if [ -z "$GREP" ]; then
  echo "grep missing"
  exit 1
fi

TRACE_LOCATION=/tmp/swatch

mkdir -p $TRACE_LOCATION

for i in $(ps -ef | grep ${GREP}| awk '{print $2}')
  do
    nohup strace -e signal=all -e trace=signal -p $i &> $TRACE_LOCATION/$i.log &
  done

nohup sh -c "while true; do ps aux >> $TRACE_LOCATION/pids; sleep 10; done" &
