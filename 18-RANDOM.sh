#!/bin/sh
array=(
21029299
00205d1c
a3da1677
1f6d12dd
890684b
)

for n in {0..32767}
do
    re=`echo $n | md5sum | cut -c 1-8`
    for((i=0;i<${#array[*]};i++))
    do
        if [ "${array[i]}" == "$re" ]
        then
            echo -e "${n} --- $re" |tee -a /tmp/md5.log
        fi
    done
done
wait
