#!/bin/bash
SERVER_IP=`ifconfig|grep 'inet 10.'|awk '{print $2}'|cut -d" " -f1`
ROOT_DISK=`/bin/df -h|grep /dev/mapper/centos-root|awk -F" " '{print $5}'|cut -d"%" -f1`
HOME_DISK=`/bin/df -h|grep /dev/mapper/datavg-lv_data|awk -F" " '{print $5}'|cut -d"%" -f1`
 
if [ $ROOT_DISK -ge 70 ];then
/usr/local/bin/sendEmail -f jie.wan@daocloud.io -s smtp.163.com -u " The ROOT_DISK of $SERVER_IP-$HOSTNAME is warning!" -o message-content-type=html -o message-charset=utf8 -xu jie.wan@daocloud.io -xp zh@123bj -m "The ROOT_DISK of $SERVER_IP-$HOSTNAME，now use% is 90%，please deal with it as soon as possible"
/usr/local/bin/sendEmail -f jie.wan@daocloud.io -t webmaster@wanjie.info -s smtp.163.com -u " The ROOT_DISK of $SERVER_IP-$HOSTNAME is warning!" -o message-content-type=html -o message-charset=utf8 -xu jie.wan@daocloud.io -xp zh@123bj -m "The ROOT_DISK of $SERVER_IP-$HOSTNAME，now use% is 70%，please deal with it as soon as possible"
else
echo "The ROOT_DISK of $SERVER_IP-$HOSTNAME is Enough to use"
fi
 
sleep 5
 
if [ $DATA_DISK -ge 95 ];then
/usr/local/bin/sendEmail -f jie.wan@daocloud.io -s smtp.163.com -u " The HOME_DISK of $SERVER_IP-$HOSTNAME is warning!" -o message-content-type=html -o message-charset=utf8 -xu jie.wan@daocloud.io -xp zh@123bj -m "The HOME_DISK of $SERVER_IP-$HOSTNAME，now use% is 95%，please deal with it as soon as possible"
/usr/local/bin/sendEmail -f jie.wan@daocloud.io -t webmaster@wanjie.info -s smtp.163.com -u " The HOME_DISK of $SERVER_IP-$HOSTNAME is warning!" -o message-content-type=html -o message-charset=utf8 -xu jie.wan@daocloud.io -xp zh@123bj -m "The HOME_DISK of $SERVER_IP-$HOSTNAME，now use% is 95%，please deal with it as soon as possible"
else
echo "The ROOT_DISK of $SERVER_IP-$HOSTNAME is Enough to use"
fi
 
===============================================================
设置计划任务
[root@jie ~]# crontab -e
*/30 * * * *　/bin/bash -x /root/root_disk.sh > /dev/null 2>&1


mail -s "tenant stat is here" < /tmp/total-mail.txt jie.wan@daocloud.io

