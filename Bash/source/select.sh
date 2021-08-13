#! /bin/bash

select name in "$@";
do
	echo ${name} ${REPLY}

	# 用于结束select
	if [[ ${REPLY} == "stop" ]]
	then
		break
	fi
done

