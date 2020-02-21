# monitor-waiting for eth0 to become free event and send email
#!/bin/sh
# powered by webmaster@wanjie.info
# Created at 2019-12-13
# 前因参考 https://www.jianshu.com/p/96d7e2cd9e99
# 这就是内核太老，用户又不敢升级的一个临时解决方法
#请加入计划任务，每分钟执行，有问题请反馈
#假定脚本存放位置 为/home下面 /home/kernel-waiting-netdevice.sh
#修改为可执行  chmod a+x kernel-waiting-netdevice.sh
#命令模式 crontab -e 进入计划任务编辑模式
#添加如下代码 */1 * * * * sh /home/kernel-waiting-netdevice.sh 这样开启每分钟监控模式
#可能存在的问题，最后100行日志中发现不了 unregister_netdevice 字段，需要调整数字为更大，例如200或300+

 
# 监听日志中统计达到3次 "kernel:unregister_netdevice: waiting for eth0 to become free. Usage count = 1"，任一字段
 
tongji=`tail -n 100 /var/log/messages | grep "unregister_netdevice"|wc -l`
 
#echo $tongji
 
# 如果 统计数 大于3（每分钟执行），理论上出现问题时会有6次,则重启机器
if [ "$tongji" -gt  "3" ]; then
   
    #新建重启记录文件
    touch /var/log/unregister_netdevice-reboot.log
     
    # 将日志写入日志文件
        echo $(date "+%F %H:%M:%S") - netdevice error reboot >> /var/log/unregister_netdevice-reboot.log
    
   #发邮件记录并重启
 
mail -s "netdevice error reboot" < /var/log/unregister_netdevice-reboot.log webmaster@wanjie.info
    
#故障日志写零，下次重新开始
cat /dev/null > /var/log/unregister_netdevice-reboot.log
#执行自动重启
   reboot
 
fi
