#!/bin/sh
#status=(`$LOGIN -e "show slave status\G" | egrep "_Running|_Behind_Master" | awk '{print $NF}'`)
arr(){
status=($(mysql -uroot -p123 -S /data/3307/mysql.sock -e "show slave status\G" | egrep "_Running|_Behind_Master" | awk '{print $NF}'))
}
USER=root
PS=123
SOCK=/data/3307/mysql.sock
LOGIN="mysql -u$USER -p$PS -S $SOCK"

function slave(){
if [ "${status[0]}" == "Yes" ] && [ "${status[1]}" == "Yes" ] && [ ${status[2]} -eq 0 ]
then
    echo "${status[*]}"
else
    echo "cuowu"
fi
}

main(){
while true
do
    arr
    slave
    sleep 10
done
}
main
