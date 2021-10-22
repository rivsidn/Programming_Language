#! /bin/bash

var='global'

function func1() {
	local var='local'

	echo ${var}
	unset var
	echo ${var}

	func2
}

function func2() {
	unset var
	echo "enter..."
	echo ${var}
	echo "exit..."
}

func1

<<COMMENT
输出:
$ ./local1.sh
local

enter...
global
exit...

在func1() 中定义了本地变量 local，unset 之后还是不能获取到全局var 的值
在func2() 中将var unset 之后就能继续获取到全局变量的值
COMMENT
