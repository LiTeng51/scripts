#!/bin/sh
. /etc/init.d/functions

array=(
http://www.baidu.com
http://www.etiantian.org
http://www.taobao.com
http://oldboy.blog.51cto.com
http://10.0.0.7 
)


for n in `seq 0 $((${#array[*]}-1))`
do
   a=`curl -I -s ${array[$n]} |head -1 | grep 200 | wc -l`
    if [ $a -eq 1 ]
    then
        action "${array[$n]}" /bin/true
    else
        action "${array[$n]}" /bin/false
    fi
done
