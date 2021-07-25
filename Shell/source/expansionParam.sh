#! /bin/bash

AA=aa

# 当AA 没设置或者为空的时候，将~ 展开为家目录
echo ${AA:-~}

set -- 0 1 2 3 4 5 6 7 8 9 0 a b c d e f g h
echo ${@:1:7}
echo ${*:1:7}

array=(0 1 2 3 4 5 6 7 8 9 0 a b c d e f g h)
echo ${array[@]:0:7}
echo ${array[*]:0:7}

echo "------------------------"

PRE_AA=aa
PRE_BB=bb
PRE_CC=cc

echo ${!PRE_*}
echo ${!PRE_@}

for var in ${!PRE_*}
do
	echo ${!var}		# 输出展开之后的数据
done

for var in ${!PRE_@}
do
	echo ${!var}		# 输出展开之后的数据
done

echo "------------------------"

function func() {
	echo $1
	echo $2
	echo $3
}

func "${!PRE_*}"		# 一个完整的值
func "${!PRE_@}"		# 一系列分开的值

:<<COMMENT
输出:
PRE_AA PRE_BB PRE_CC


PRE_AA
PRE_BB
PRE_CC
COMMENT

echo "------------------------"

var=1234567890
echo ${#var}			# 显示字符串的个数

echo "------------------------"

var=AABC
echo ${var,?}
echo ${var,,A}			# 转换大小写，只能匹配一个

echo "------------------------"

str='string'
echo ${str@a}



