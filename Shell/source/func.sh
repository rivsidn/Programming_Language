#! /bin/bash

fun() {
	return 10
}

fun

echo $?

# 显示函数的名称和定义
declare -f
typeset -f 
# 只是显示函数的名称
declare -F
typeset -F

