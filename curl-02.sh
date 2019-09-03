#!/bin/sh
. /etc/init.d/functions
#curl -o /dev/null -sL www.baidu.com -w "%{http_code}\n"
array=(
http://www.etiantian.org
http://www.taobao.com
http://oldboy.blog.51cto.com
http://www.baidu.com
http://10.0.0.7 
)

function wait(){
    echo "wait 3s"
for((i=0;i<3;i++))
do
    echo "."
    sleep 1
done
}

function web(){
wget -T 5 -t 2 --spider $1 &>/dev/null
R=$?
if [ $R -eq 0 ]
then
    action "$1" /bin/true
    return $R
else
    action "$1" /bin/false
    return $R
fi
}

main(){
wait
    for n in ${array[*]}
do
    web $n
done
}
main $*
