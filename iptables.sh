#!/bin/bash
. /etc/init.d/functions
function log(){
awk '{S[$1]++}END{for (key in S) print S[key],key}' /application/nginx/logs/access/www_access.log >/tmp/www.log
#awk '{print $1}' /application/nginx/logs/access/www_access.log |sort|uniq -c|sort -rn -k1 >/tmp/www.log
}

function add(){
exec </tmp/www.log
while read line
do
    ip=$(echo "$line" | awk '{print $2}')
    pv=$(echo "$line" | awk '{print $1}')

    if [ $(echo ${ip}|egrep -o "\." |wc -l) -ne 3 ]
    then
        continue
    fi

    if [ $pv -gt 100 -a `iptables -nL | grep $ip | wc -l` -eq 0 ]
    then
        iptables -I INPUT -s $ip -j DROP
        if [ $(iptables -nL | grep $ip | wc -l) -ge 1 ]
        then
            action "iptable $ip" /bin/true
            echo $ip >>/tmp/www_iptable_$(date +%F).log
        else
            action "iptable $ip" /bin/false
        fi
    fi
done
}

function del(){
while read line1
do
	if [ `iptables -nL | grep $ip | wc -l` -ge 1 ]
	then
	    iptables -D INPUT -s $line1 -j DROP &>/dev/null
	fi
done</tmp/www_iptable_$(date +%F -d -1day).log
}

main(){
while true
do
    log
    add
deltime=$(date +%H:%M:%S)
if [[ "$deltime" < 00:08:00 ]]
then

    del
fi
sleep 180
done
}
main $*
