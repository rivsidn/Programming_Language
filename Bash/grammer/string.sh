#! /bin/bash

if [ ! -z $st ]
then
	echo "not null"
else
	echo "null"
fi

str="test"
echo "${str:-0}"

