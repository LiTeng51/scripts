#!/bin/sh
. /etc/init.d/functions
[ $UID -ne 0 ] && echo "user not root" && exit 1

for n in li{00..01}
do
    user=$(grep "^.*${n}.*$" /etc/passwd | wc -l)
    if [ $user -eq 1 ]
    then
        action "cuowu" /bin/false
        continue
    fi
    password=`openssl rand -base64 40 | sed -r 's#[^a-zA-Z0-9]##g' | cut -c 1-8`
    useradd $n && \
    echo "${password}" | passwd --stdin $n &>/dev/null
    user1=$(grep "^.*${n}.*$" /etc/passwd | wc -l)
    if [ $user1 -eq 1 ]
    then
        action "chenggong" /bin/true
        echo "${password}----->$n" >>/tmp/password.log
    fi
done
