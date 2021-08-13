#! /bin/bash

# 电子书批量转换
# 由于文件名中可能包含空格，需要提前设置IFS

IFS=$'\n'

for file in `ls *.epub`
do
#	echo ${file}
	name=`echo ${file} | cut -d '.' -f 1`
	ebook-convert ${file} ${name}.pdf
done

