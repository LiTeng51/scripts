#!/bin/sh
function trapper(){
	trap '' 1 2 3 15 20
}

function menu(){
cat<<-END
==============================
        1)10.0.0.4
        2)10.0.0.5
        3)10.0.0.6
        4)10.0.0.7
        5)10.0.0.88
        6)exit
==============================
END
}

function host(){
read -p "请选择要连接的服务器：" A
case "$A" in
    	1)
    	ssh -p"22" ${USER}@10.0.0.4
    	;;
        2)
        ssh -p"22" ${USER}@10.0.0.5
        ;;
        3)
        ssh -p"22" ${USER}@10.0.0.6
        ;;
        4)
        ssh -p"22" ${USER}@10.0.0.7
        ;;
        5)
        ssh -p"22" ${USER}@10.0.0.88
        ;;
        6)
    	exit 0
        ;;
        *)
        echo "输入数字1-6"
        host
        ;;
esac
}

main(){
while true
do
	trapper
	clear
	menu
	host
done
}
main
