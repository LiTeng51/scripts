#!/bin/bash
#export MYSQL_PWD=123
USER='root'
PASSWD='123'
sock='/data/3307/mysql.sock'
CMD="mysql -u$USER  -p$PASSWD -S ${sock}"
error=(1158 1159 1008 1007 1062)

function check_slave(){
if [ "${status[0]}" = "Yes" -a "${status[1]}" = "Yes" -a "${status[2]}" = "0" ]
then
	echo "mysql is ok"
else
	echo "mysql is down"
	#mail -s "123"
fi
}

function check_SQL(){
if [ "${status[3]}" = "0" ]
then
	return 0
else
	return 1
fi
}

function skip(){
check_SQL
if [ $? -ne 0 ]
then
	for ((i=0;i<=${#error[@]};i++))
	do
		if [ "${status[3]}" = "${error[$i]}" ]
		then
			$CMD -e "stop slave;set global sql_slave_skip_counter = 2;start slave"
		fi
	done
fi
}

function ag(){
check_SQL
if [ $? -ne 0 ]
then
echo "SQL down"
fi
}

main(){
while true
do
status=($(${CMD} -e "show slave status\G"| egrep "(Slave_IO_Running:|Slave_SQL_Running:|Seconds_Behind_Master:|Last_Errno:)"|awk '{print $2}'))
	check_slave
	skip
	ag
sleep 5
done
}
main
