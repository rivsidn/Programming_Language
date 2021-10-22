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



:<<COMMENT
为什么通过这种方式获取到的${line} 不能作为连接数组的下标

declare -A assArray

cat test.txt | while read line
do
	assArray[${line}]='y'
done

echo "${assArray[@]}"		# 此时会显示为空，这里是为什么？

COMMENT
