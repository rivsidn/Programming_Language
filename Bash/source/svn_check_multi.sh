#! /bin/bash

SVN_PATH="https://xxxxx.xxxx"
FILE_PRE="svn_code_"

svn_check() {
	/usr/bin/timeout -s 9 3 svn checkout ${SVN_PATH} ${FILE_PRE}${1}

	rm -rf ${FILE_PRE}${1}
}

declare -i i
declare -i max

max=1000000
for((i=0;i<=${max};i++))
do
	svn_check ${i} &

	if [ $i -eq ${max} ]
	then
		i=0
	fi

	sleep 1
done

