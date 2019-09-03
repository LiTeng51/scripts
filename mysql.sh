#!/bin/bash
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
PORT=$2
PASSWD='123'
USER='root'
sock="/data/${PORT}/mysql.sock"
cnf="/data/${PORT}/my.cnf"

tishi(){
if [ -e "$sock" ]
then
	action "mysql $1" /bin/true
else
	action "mysql $1" /bin/false
fi
}

function start(){
if [ -e "$sock" ]
then
	echo "mysql is running"
else
	/usr/local/sbin/mysqld_safe --defaults-file=${cnf} 2>&1 >/dev/null &
	sleep 3
	tishi start
fi
}

function stop(){
if [ ! -e "$sock" ]
then
	echo "mysql is stopped"
else
	/usr/local/sbin/mysqladmin -u$USER -p$PASSWD -S $sock shutdown &>/dev/null &
	RETVAL=$?
	sleep 2
	if [ $RETVAL -eq 0 ]
	then
		action "mysql is stopped" /bin/true
	else
		action "mysql is stopped" /bin/false
	fi
	
fi
}

function status(){
if [ -e "$sock" ]
then
	echo "mysql is running"
else
	echo "mysql is stopped"
fi
}

if [ ! "$2" = "3307" -a ! "$2" = "3306" ]
then
	echo "start (3306|3307)"
	exit 1
fi

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	restart)
		stop
		sleep 3
		start
		;;
	status)
		status
		;;
	*)
		echo "pls input (start|stop|restart|status)"
		;;
esac
