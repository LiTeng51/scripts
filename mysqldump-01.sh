#!/bin/sh
. /etc/init.d/functions

US=root
PS=123
SOCK=/data/3306/mysql.sock
LOGIN="/usr/local/sbin/mysql -u$US -p$PS -S $SOCK"
DUMP="/usr/local/sbin/mysqldump -u$US -p$PS -S $SOCK"
DATABASE=$($LOGIN -e "show databases" | egrep -v "mysql*|*schema" | sed "1d")
for database in $DATABASE
do
    [ ! -d /tmp/mysql/$database/ ] && mkdir -p /tmp/mysql/$database/
    $DUMP $database -x -B -F -R --master-data=2 | gzip >/tmp/mysql/$database/${database}_$(date +%F).sql.gz
done
