#!/bin/sh
path=/www
md5_log=/test/yuanshi_md5.log
num_log=/test/yuanshi_num.log
num=$(cat $num_log)

while true
do
	log=/test/check_md5.log
	log1=/test/check_num.log
	[ ! -f $log ] && touch $log
	[ ! -f $log1 ] && touch $log1
	md5_con=$(md5sum -c $md5_log 2>/dev/null | grep FAILED | wc -l)
	num_con=$(find $path -type f | wc -l)
	find $path -type f >/test/check_new_num.log

	
	if [ $md5_con -ne 0 ]
	then
		echo "$(md5sum -c $md5_log 2>/dev/null | grep FAILED)" >$log
		mail -s "file is xiugai" liteng51@163.com <$log
	fi
	if [ $num_con -ne $num ]
	then
		diff $num_log /test/check_new_num.log >$log1
		mail -s "file is del or mkdir" liteng51@163.com <$log1
	fi
sleep 20
done
