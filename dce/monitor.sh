#!/bin/bash

LOG_DIR="/var/log/dce"
LOG_PREFIX="top"
INTERVAL=60
LOG_ROTATE_DATE=15

while true;
do
  mkdir -p $LOG_DIR
  filename=$LOG_PREFIX-`date +"%Y-%m-%d"`.log
  filepath=$LOG_DIR/$filename
  dt=`date +"%m-%d-%Y %H:%M:%S"`

  # Print top log to $filepath
  echo "Print top log to $filepath"
  echo "========== $dt CMD: top -n 1 -b | head -n 20 ==========" >> $filepath
  top -n 1 -b | head -n 20 >> $filepath
  echo "========== $dt CMD: top -n 1 -b -o %MEM | head -n 20 ==========" >> $filepath
  top -n 1 -b -o %MEM | head -n 20 >> $filepath

  # Rotate Log
  echo "$(date +'%m-%d-%Y %H:%M:%S') Rotate log $LOG_ROTATE_DATE date ago"
  find $LOG_DIR -type f -name "$LOG_PREFIX-*.log" -mtime +$LOG_ROTATE_DATE -exec rm -f {} \;

  sleep $INTERVAL
