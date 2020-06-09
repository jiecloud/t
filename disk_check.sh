#!/bin/bash

###############################################
# Author: jie.wan@daocloud.io
# Date: 2020 6/9
# Usage: ./disk_check.sh 
# describition: based on centos7 
###############################################

NOW=`date +"%Y-%m-%d"`

#hostname主机名#
echo "#####################hostname#########################" >> /tmp/disk-check-$NOW
echo "$(hostname)" >> /tmp/disk-check-$NOW
echo $NOW 

SERVER_IP=`ifconfig|grep 'inet 10.'|awk '{print $2}'|cut -d" " -f1`

# 需要检查的磁盘，root及特定数据卷，如下例的 datavg-lv_data
ROOT_DISK=`/bin/df -h|grep /dev/mapper/centos-root|awk -F" " '{print $5}'|cut -d"%" -f1`
DATA_DISK=`/bin/df -h|grep /dev/sda1|awk -F" " '{print $5}'|cut -d"%" -f1`

echo "---disk-checking---" 
echo "---Please waiting---" 


# 磁盘空间排查
check_disk(){
# 检查根目录，根据实际环境修改

if
  [ $ROOT_DISK -lt 50 ];then
  echo "The ROOT_DISK of $SERVER_IP-$HOSTNAME，now ROOT_DISK use is $ROOT_DISK%，space very safe now _^_^_ "
fi
if
  [ $ROOT_DISK -gt 60 ];then
  echo "The ROOT_DISK of $SERVER_IP-$HOSTNAME，now ROOT_DISK use is $ROOT_DISK%，please check it "
fi
 
if
  [ $ROOT_DISK -eq 90 ];then
  echo "The ROOT_DISK of $SERVER_IP-$HOSTNAME，its dangerous now  usage is $ROOT_DISK%，，please deal with it ASAP!" 
    else
  echo "The ROOT_DISK of $SERVER_IP-$HOSTNAME is Enough to use"
fi


sleep 3

if
  [ $DATA_DISK -lt 50 ];then
  echo "The ROOT_DISK of $SERVER_IP-$HOSTNAME，now ROOT_DISK use is $ROOT_DISK%，space very safe now _^_^_. "
fi

if
  [ $DATA_DISK -gt 60 ];then
  echo "The DATA_DISK of $SERVER_IP-$HOSTNAME，now DATA_DISK use is $DATA_DISK%，please check it! "
fi
 
if
  [ $DATA_DISK -eq 90 ];then
  echo "The DATA_DISK of $SERVER_IP-$HOSTNAME，its dangerous now  usage is $DATA_DISK%，，please deal with it ASAP!" 
  else
  echo "The DATA_DISK of -$HOSTNAME is Enough to use"
fi



}

main(){

check_disk

}
main
