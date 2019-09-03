#!/bin/sh
TO=1000
MSG=500
. /etc/init.d/functions

function NUM(){
expr $1 + 1 &>/dev/null
if [ $? -ge 1 ]
then
    return 1
else
	return 0
fi

}

function consum(){
    read -p "请输入发送的内容 :" TXT
    read -p "是否发送 [Y or N]:" OPT
    case "$OPT" in
        [yY]|[yY][eE][sS])
                echo "发送成功"
                echo $TXT >>/tmp/mas.log
                ((TO=TO-MSG))
                echo "剩余 $TO"
                ;;
        [nN]|[nN][oO])
                echo "不发送"
                exit 0
                ;;
        *)
                echo "请输入 [Y or N]:"
esac
}

function cz(){
if [ $TO -lt $MSG ]
then
    echo "是否需要充值 [Y or N]:"
    read OPT2
    case "$OPT2" in
        [yY])
            while true
            do
                read -p "int:" qian
				NUM $qian
				if [ $? -eq 0 ]
				then
					break
				else
					echo "请输入数字"
				fi
            done
            ((TO+=$qian)) && echo "you have $TO"
            if [ $TO -lt $MSG ]
            then
                cz
            fi
        ;;
        [nN])
            echo "bye"
            exit 101
        ;;
        *)
            cz
		;;
        esac
fi
}

main(){
while [ $TO -ge $MSG ]
do
    consum
    cz
done
}
main
