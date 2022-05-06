#!/bin/bash

ethn=$1
tmp_fifo="$$.fifo"
mkfifo $tmp_fifo

exec 4<>$tmp_fifo
rm $tmp_fifo

for ((i=0;i<2;i++))
do
	echo
done >&4

for ((i=0;i<100000000;i++))
do
read -u4
{
	if [ $i -eq 0 ]
	then
		ip monitor link dev $ethn
		echo >&4
	else
		echo "Current Time:`date +%D-%k:%M:%S`-----------------------------------------------"
		RX_bytes_pre=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $2}')
		TX_bytes_pre=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $10}')
		RX_packets_pre=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $3}')
		TX_packets_pre=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $11}')
		sleep 10

		RX_bytes_next=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $2}')
		TX_bytes_next=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $10}')
		RX_packets_next=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $3}')
		TX_packets_next=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $11}')

		RX_bytes=$((${RX_bytes_next}-${RX_bytes_pre}))
		TX_bytes=$((${TX_bytes_next}-${TX_bytes_pre}))
		RX_packets=$((${RX_packets_next}-${RX_packets_pre}))
		TX_packets=$((${TX_packets_next}-${TX_packets_pre}))

		if [ $RX_bytes -lt 1024 ]
		then
        		RX_bytes="${RX_bytes}B/s"
		elif [ $RX_bytes -gt 1048576 ]
		then
        		RX_bytes=$(echo $RX_bytes | awk '{print $1/1048576 "MB/s"}')
		else
        		RX_bytes=$(echo $RX_bytes | awk '{print $1/1024 "KB/s"}')
		fi

		if [ $TX_bytes -lt 1024 ]
		then
        		TX_bytes="${TX_bytes}B/s"
		elif [ $TX_bytes -gt 1048576 ]
		then
        		TX_bytes=$(echo $TX_bytes | awk '{print $1/1048576 "MB/s"}')
		else
        		TX_bytes=$(echo $TX_bytes | awk '{print $1/1024 "KB/s"}')
		fi

		echo -e "$1 \t RX:bytes    packets  TX:bytes    packets "
		echo -e "$1 \t RX:$RX_bytes $RX_packets   TX_bytes:$TX_bytes $TX_packets"
		echo >&4
	fi

} & 
done

wait
echo "control-c"
#trap exec 4>$-
exec 4>$-
