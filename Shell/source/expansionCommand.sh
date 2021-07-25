#! /bin/bash

# 命令替换

echo $(ls -A)
echo `ls -A`

echo $(cat $(ls -A))

# 命令替换可以循环循环递归调用，当用这种方式的时候需要加转义
echo `cat \`ls -A\``



