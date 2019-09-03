#!/bin/sh
USER=root
PSD=123
SOCK=/data/3307/mysql.sock
CMD="mysql -u$USER -p$PSD -S $SOCK"
errno=(1158 1159 1008 1007 1062)


check_status() {
if [ "${status[0]}" == "Yes" -a "${status[1]}" == "Yes" -a "${status[2]}" == "0" ]
then
    echo "mysql is ok"
    sta=0
    return $sta
else
	return 2
fi
}

check_error() {
check_status
if [ $? -ne 0 ]
then
    for((i=0;i<${#errno[*]};i++))
    do
        if [ "${errno[i]}" == "${status[3]}" ]
        then
            $CMD -e "stop slave;set global sql_slave_skip_counter = 2;start slave"
        fi
    done
fi
}

check_again() {
    status=($($CMD -e "show slave status\G" | egrep "*_Running|Seconds_Behind_Master|Last_SQL_Errno" | awk '{print $NF}'))
    ckeck_status &>/dev/null
    if [ $? -ne 0 ]
    then
        echo "mysql slave is not ok `date +%F`" | tee /tmp/slave.log
        mail -s "mysql slave is not ok `date +%F`" liteng51@163.com </tmp/slave.log
    fi
}

main() {
while true
do
status=($($CMD -e "show slave status\G" | egrep "*_Running|Seconds_Behind_Master|Last_SQL_Errno" | awk '{print $2}'))
    check_error
    check_again
    sleep 5
done
}
main
