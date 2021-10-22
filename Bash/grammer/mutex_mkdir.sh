#! /bin/bash

FILE="/tmp/.exclusivelock"

if mkdir ${FILE}
then
	echo "in  and sleep 3"
	sleep 3
	echo "out and sleep 3"
	rmdir ${FILE}
fi
