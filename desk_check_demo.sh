#!/bin/bash

###############################################
# Author: webmaster@wanjie.info
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


# 磁盘空间排查
check_disk(){
# 检查根目录，根据实际环境修改
ROOT_DISK=`df -Th | grep -w / | awk '{print $6}'| awk -F "%" '{print $1}'`
if
  [ $ROOT_DISK -gt 70 ];then
  echo "The ROOT_DISK of $SERVER_IP-$HOSTNAME，now use% is $ROOT_DISK%，please check it "
fi

if
  [ $ROOT_DISK -eq 90 ];then
  echo "The ROOT_DISK of $SERVER_IP-$HOSTNAME，its dangerous now  usage is $ROOT_DISK%，，please deal with it ASAP"
fi


sleep 5

DATA_DISK=`df -Th | grep -w / | awk '{print $6}'| awk -F "%" '{print $1}'`
if
  [ $DATA_DISK -gt 70 ];then
  echo "The DATA_DISK of $SERVER_IP-$HOSTNAME，now use% is $DATA_DISK%，please check it "
fi

if
  [ $DATA_DISK -eq 90 ];then
  echo "The DATA_DISK of $SERVER_IP-$HOSTNAME，its dangerous now  usage is $DATA_DISK%，，please deal with it ASAP"
fi
}

main(){

check_disk

}
main
