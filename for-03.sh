#!/bin/sh
array=(I am oldboy teacher welcome to oldboy training class)
for((n=0;n<${#array[*]};n++))
do
    if [ ${#array[$n]} -lt 6 ]
    then
        echo "${array[$n]}"
    fi
done
