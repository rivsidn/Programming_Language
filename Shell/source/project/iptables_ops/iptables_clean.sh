#! /bin/bash


errExit() {
	case $1 in
		1)
			echo "ERROR: must be root"
			;;
		*)
			;;
	esac

	exit
}


# 必须为root
if [ ${EUID} -ne 0 ]; then
	errExit 1
fi

tables=`iptables-save | grep '^*' | sed 's/.//'`

# 表项清空
for table in ${tables}
do
	iptables -t ${table} -F
done

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
				return 0
			fi
			;;
		"nat")
			if [ -z ${nat[$2]} ]
			then
				return 0
			fi
			;;
		"mangle")
			if [ -z ${mangle[$2]} ]
			then
				return 0
			fi
			;;
		"raw")
			if [ -z ${raw[$2]} ]
			then
				return 0
			fi
			;;
	esac

	return 1
}

for table in ${tables}
do
	for list in `iptables-save -t ${table} | grep '^:' | sed 's/.//' | cut -d ' ' -f 1`
	do
		isNewList ${table} ${list}
		if [ $? -eq 0 ]
		then
			echo "iptables -t ${table} -X ${list}"
			iptables -t ${table} -X ${list}
		fi
	done
done

# 添加全通规则
iptables -I INPUT -j ACCEPT
iptables -I FORWARD -j ACCEPT
iptables -I OUTPUT -j ACCEPT

