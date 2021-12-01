#! /bin/bash

declare -i i
declare -i index

index=200
for((i=0;i<=${index};i++))
do
	echo ${i}
	# 执行到开始之后重复执行
	if [ ${i} -eq $index ]
	then
		i=0
	fi
done


