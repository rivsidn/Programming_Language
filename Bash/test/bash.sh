#! /bin/bash

exec 4<test_file

for((;;))
do
	sleep 1
	read -u 4 line
	echo ${line}
done

