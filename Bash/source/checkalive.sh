#! /bin/bash

for ((;;))
do
	ping -c 1 -W 5 172.31.7.254 > /dev/null

	if [ $? -eq 0 ]
	then
		echo `date` ": alived" 
	else
		echo `date` ": not alived"
	fi

	sleep 20
done

