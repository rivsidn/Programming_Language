#! /bin/bash

declare -A filter

filter=([INPUT]=1 [FORWARD]=1 [OUTPUT]=1)

echo ${filter["INPUT"]}
echo ${filter["NIHAO"]}

if [ -z ${filter["NIHAO"]} ]
then
	echo "empty"
else
	echo "not empty"
fi



