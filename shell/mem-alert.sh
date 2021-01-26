#!/bin/sh
# change ftqq key $key
# send detail file to keep.sh and email
ramusage=$(free | awk '/Mem/{printf("RAM Usage: %.2f\n"), $3/$2*100}'| awk '{print $3}')

if [ "$ramusage" > 40 ]; then

  SUBJECT="ATTENTION: Memory Utilization is High on $(hostname) at $(date)"
  MESSAGE="/tmp/Mail.out"
  TO="https://free.keep.sh"
  #TO="webmaster@wanjie.info"
 echo "Memory Current Usage is: $ramusage%" >> $MESSAGE
 echo "" >> $MESSAGE
 echo "------------------------------------------------------------------" >> $MESSAGE
 echo "Top Memory Consuming Process Using top command" >> $MESSAGE
 echo "------------------------------------------------------------------" >> $MESSAGE
 echo "$(top -b -o +%MEM | head -n 20)" >> $MESSAGE
 echo "" >> $MESSAGE
 echo "------------------------------------------------------------------" >> $MESSAGE
 echo "Top Memory Consuming Process Using ps command" >> $MESSAGE
 echo "------------------------------------------------------------------" >> $MESSAGE
 #echo "$(ps -eo pid,ppid,%mem,%Memory,cmd --sort=-%mem | head)" >> $MESSAGE
 echo "$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -10)" >> $MESSAGE
  #mail -s "$SUBJECT" "$TO" < $MESSAGE
 # curl --upload-file $MESSAGE "$TO"
 #curl   'https://sc.ftqq.com/$key?text=SomeProcessWasVeryHigh'
  #dizhi=$(curl --upload-file /tmp/Mail.out https://free.keep.sh)
  dizhi=$(curl --upload-file $MESSAGE "$TO")
  echo $dizhi > /tmp/dizhi1.txt
# rm /tmp/Mail.out
fi
