#!/bin/sh
. /etc/init.d/functions

function ip(){
cat /tmp/access_2010-12-9.log | awk '{print $1}' | sort | uniq -c>/tmp/a.log
#netstat -an | grep ESTABLISHED | awk -F '[ :]+' '{print $6}'| sort | uniq -c>b.log
# awk '{A[$1]++}END{for(key in A) print A[key],key}' /tmp/access_2010-12-9.log | sort >/tmp/a.log
#exec<b.log
exec</tmp/a.log
while read line
do
    pv=`echo $line | awk '{print $1}'`
    ip=`echo $line | awk '{print $2}'`
    if [ $pv -ge 10 -a `iptables -L -n | grep $ip | wc -l` -eq 0 ]
    then
        iptables -I INPUT -s $ip -j DROP
        echo "$ip" >>/tmp/$(date +%F)_iptables.log
    fi
done
}

function del(){
exec </tmp/$(date +%F -d '-1day')_iptables.log
while read line
do
    if [ `iptables -L -n | grep -o $line | wc -l` -ge 1 ]
    then
        iptables -D INPUT -s $line -j DROP
    fi
done
}

main(){
while true
do
    ip
    sleep 3
    del
done
}
main
