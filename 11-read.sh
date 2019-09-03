#!/bin/sh
. /etc/init.d/functions


function cz(){
if [ -z "$a" ]
then
    echo "qingshiyong"
    exit 2
elif [ -z "$b" ]
then
    echo "qingshiyong"
    exit 23
fi
}

function zs(){
expr $a + $b + 1 &>/dev/null
RE=$?
if [ $RE -ne 0 ]
then
    echo "this cuowu"
    exit 1
else
    return 0
fi
}

function bi(){
if [ $a -eq $b ]
then
    echo "$a=$b"
elif [ $a -lt $b ]
then
    echo "$a<$b"
elif [ $a -gt $b ]
then
    echo "$a>$b"
fi
}

main(){
read -p "chuancan" a b
if [ -z $a ]
then
exit 66
fi
if [ -z $b ]
then
exit 67
fi
cz
zs
bi
}
main
