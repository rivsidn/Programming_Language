#! /bin/bash

BAKPATH=/etc/bakmod
BAKLIST=mod.list

declare -A modExist

for mod in `cat modules.txt`
do
	modExist[${mod}]='y'
done

mkdir -p ${BAKPATH}

for mod in `lsmod | cut -d ' ' -f 1`
do
	if [ "${modExist[${mod}]}y" = "yy" ]
	then
		echo "" > /dev/null
	else
		find /lib/ -name ${mod}.ko >> ${BAKPATH}/${BAKLIST}
		find /lib/ -name ${mod}.ko -exec mv {} ${BAKPATH} \;
	fi
done

