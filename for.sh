#!/bin/sh
#a=(I am oldboy teacher welcome to oldboy training class.)
for n in I am oldboy teacher welcome to oldboy training class.
do
    if [ "${#n}" -lt 6 ]
    then
        echo "$n"
    fi
done
