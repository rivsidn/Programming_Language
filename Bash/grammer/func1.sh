#! /bin/bash


function func1() {
	# 此时输出global
	# 当func2 在 var 下调用的时候输出 'func1 local'
	func2
	local var='func1 local'
}

function func2() {
	echo ${var}
}

var=global

func1

