#!/bin/sh
for n in `ls | grep "^.*html$"`
do
    mv $n `echo $n | sed 's#li#linux#g'|sed 's@html@HTML@g'`
done
