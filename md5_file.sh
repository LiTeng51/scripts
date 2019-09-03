#!/bin/sh
#md=`echo $RANDOM | md5sum | cut c 1-10`
for n in `seq 10`
do
    md=`echo $RANDOM | md5sum | tr "[0-9]" "[a-z]"|cut -c 1-10`
    mc=`openssl rand -base64 40 | sed 's#[^a-z]##g' | cut -c 2-11`
    touch /scripts/file/${mc}_olbdoy.html
done
