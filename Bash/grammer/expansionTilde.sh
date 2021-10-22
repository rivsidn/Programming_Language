#! /bin/bash

# expansion 1
# 波浪线展开

PATH=`pwd`
echo ~+
cd ~/
pushd `pwd`
cd ..
pushd `pwd`
cd ${PATH}

echo "------------"

dirs		# 打印顺序依次为当前目录、目录出栈顺序
dirs +0		# 当前目录
dirs -0		# 最早入栈的目录

echo "------------"

echo ~+0	# 等同于dir +0 但是已经展开
echo ~-0



