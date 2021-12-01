#! /bin/bash

func() {
	echo "$1 enter..."
	sleep 3
	echo "$1 exit ..."
}

for((i=0;i<10000;i++))
do
	#后台执行函数
	func ${i} &
	sleep 1
done

