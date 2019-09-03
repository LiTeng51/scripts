#!/bin/sh
. /etc/init.d/functions
>/tmp/ip.log
>/tmp/ipp.log
trap "echo 'bye';exit" 2
NET=10.0.0.
for IP in `seq $1`
do
if [ $IP -eq 0 -o $IP -eq 255 ]
then
continue
fi
    (
    ping -w 1 -c 1 ${NET}${IP} &>/dev/null
    if [ $? -eq 0 ]
    then
        action "${NET}${IP}" /bin/true
        echo "${NET}${IP}" >>/tmp/ip.log
    else
        action "${NET}${IP}" /bin/false
        echo "${NET}${IP}" >>/tmp/ipp.log
   fi
   )&
done
wait
wc -l /tmp/ip.log | awk '{print $1}'
#nc -w 1 10.0.0.88 -z 1-100
