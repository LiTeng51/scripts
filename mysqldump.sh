#!/bin/sh
USER=root
PS=123
SOCK=/data/3306/mysql.sock
LOGIN="mysql -u$USER -p$PS -S $SOCK"
DUMP="mysqldump -u$USER -p$PS -S $SOCK"
DATABASES=$($LOGIN -e "show databases"| egrep -v "*schema|mysql*" | sed "1d")
for databases in $DATABASES
do
    TABLES=$($LOGIN -e "show tables from $databases"| sed '1d')
    for table in $TABLES
    do
        [ ! -d /tmp/mysqldmup/$databases/ ] && mkdir -p /tmp/mysqldmup/$databases/
        $DUMP $databases $table -x -R -F --master-data=2| gzip >/tmp/mysqldmup/$databases/${table}_$(date +%F).sql.gz
    done
done
