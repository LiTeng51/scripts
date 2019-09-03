#!/bin/sh
. /etc/init.d/functions

PO=$1
US=root
PD=123
SOCK=/data/${PO}/mysql.sock
VB=/usr/local/sbin

function menu(){
cat <<-ER
        1.start
        2.stop
        3.restart
        4.exit
        5.status
ER
}

start(){
if [ ! -e $SOCK ]
then
/bin/sh ${VB}/mysqld_safe --defaults-file=/data/${PO}/my.cnf &>/dev/null &
    sleep 3
    if [ -e $SOCK ] && [ `netstat -lntup | grep ${PO} | wc -l` -eq 1 ]
    then
        action "start mysql" /bin/true
    else
        action "start mysql" /bin/false
    fi
else
    echo "runing mysql........."
fi
}

stop(){
if [ -e $SOCK ]
then
${VB}/mysqladmin -u$USER -p$PD -S $SOCK shutdown >/dev/null 2>&1
    sleep 3
    if [ ! -e /data/${PO}/mysql.sock ]
    then
        action "stop mysql" /bin/true
    else
        action "stop mysql" /bin/true
    fi
else
    echo "mysql for stop......."
fi
}

status(){
if [ -e $SOCK ] && [ `netstat -lntup | grep ${PO} | wc -l` -eq 1 ]
then
    echo "mysql in start......"
elif [ ! -e $SOCK ] && [ `netstat -lntup | grep ${PO} | wc -l` -eq 0 ]
then
    echo "mysql in stop......."
fi
}

function mysql(){
read -p "mysql---:" v
        case "$v" in
            1)
                start
                ;;
            2)
                stop
                ;;
            3)
                stop
                sleep 1
                start
                ;;
            4)
                exit 0
                ;;
            5)
                status
                ;;
            *)
                echo "shur 1-5"
                mysql
                ;;
        esac
}

main(){
menu
mysql
}
main $*
