#! /bin/bash

# switch case 实现 fallthrough 功能

A=1

case $A in
	1)
		echo "1"
		;&
	2)
		echo "2"
		;&
	3)
		echo "3"
		;&
	*)
		echo "*"
		;;
esac
