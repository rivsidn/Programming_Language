#! /bin/bash

BAKPATH=/etc/bakmod
BAKLIST=mod.list

for mod in `cat ${BAKPATH}/${BAKLIST}`
do
	name=${mod##*/}
	mv ${BAKPATH}/${name} ${mod}
done


