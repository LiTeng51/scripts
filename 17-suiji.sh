#!/bin/sh
trap "exit" 2
>/tmp/suiji.log
function re() {
ren="$(($RANDOM%100))"
if [ `egrep -w "$ren" /tmp/suiji.log | wc -l` -eq 1 ]
then
    continue
fi
}

function zhua() {
read -p "请输入名字：" name
if [ "$name" == "exit" ]
then
    break
fi
if [ `egrep -w "$name" /tmp/suiji.log | wc -l` -ge 1 ]
then
    echo "请重新输入"
    continue
fi
echo -e "$name\t\t$ren" |tee -a /tmp/suiji.log
}

main() {
while :
do
    re
    zhua
done
echo "jieshu"
sort -rn -k1 /tmp/suiji.log
}
main
