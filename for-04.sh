#!/bin/sh
array=(I am oldboy teacher welcome to oldboy training class)
for n in `seq 0 $((${#array[*]}-1))`
do
    if [ ${#array[n]} -le 6 ]
    then
        echo ${array[n]}
    fi
done
