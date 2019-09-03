#!/bin/sh
. /etc/init.d/functions
for n in `seq -w 2`
do
NUM=`echo $RANDOM | md5sum | cut -c 1-8`
    useradd stu$n &>/dev/null \
  echo $NUM | passwd --stdin stu$n &>/dev/null
    if [ $? -eq 0 ]
    then
        action "useradd stu$n" /bin/true
    else
        action "useradd stu$n" /bin/false
    fi
  echo "${NUM}:stu${n}" >>/tmp/passwd.log
done
