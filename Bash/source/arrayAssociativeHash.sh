#! /bin/bash

# 通过链接数组实现hash 功能

declare -A hashMap

keys="aa bb cc dd"

for key in ${keys}
do
	hashMap[${key}]='y'
done

while true
do
	read key
	if [ "${hashMap[$key]}y" = "yy" ]
	then
		echo "exist"
	else
		echo "not exist"
	fi
done




