#! /bin/bash

tables=`iptables-save | grep '^*' | sed 's/.//'`

# 删除附加的链
declare -A filter
declare -A nat
declare -A mangle
declare -A raw
raw=([PREROUTING]=1 [OUTPUT]=1)
nat=([PREROUTING]=1 [INPUT]=1 [OUTPUT]=1 [POSTROUTING]=1)
filter=([INPUT]=1 [FORWARD]=1 [OUTPUT]=1)
mangle=([PREROUTING]=1 [INPUT]=1 [FORWARD]=1 [OUTPUT]=1 [POSTROUTING]=1)

isNewList() {
	case $1 in
		"filter")
			if [ -z ${filter[$2]} ]
			then
				return 1
			fi
			;;
		"nat")
			if [ -z ${nat[$2]} ]
			then
				return 1
			fi
			;;
		"mangle")
			if [ -z ${mangle[$2]} ]
			then
				return 1
			fi
			;;
		"raw")
			if [ -z ${raw[$2]} ]
			then
				return 1
			fi
			;;
	esac

	return 0
}

isEmpty() {
	exist=`iptables-save -t $1 | grep "\-A $2"`

	if [ -z "${exist}" ]
	then
		return 1
	else
		return 0
	fi
}

delChain() {
	echo "#######"
	echo $1 $2
	rule=`iptables-save -t $1 | grep "\-j $2" | cut -b 3-`
	echo ${rule}

	iptables-save -t $1 | while read line
	do
		rule=``
	done
	iptables -t $1 -X $2
<<COMMENT
	echo "iptables -t $1 -D ${rule}"
	iptables -t $1 -D ${rule}
	echo "iptables -t $1 -X $2"
COMMENT
}

for table in ${tables}
do for list in `iptables-save -t ${table} | grep '^:' | sed 's/.//' | cut -d ' ' -f 1`
	do
		isNewList ${table} ${list}
		if [ $? -eq 1 ]
		then
			# 处理自己添加的链
			isEmpty ${table} ${list}
			if [ $? -eq 1 ]
			then
				delChain ${table} ${list}
			fi
		fi
	done
done


