#! /bin/bash

function func() {
	local var="variable"
}

# 加了local 标识的变量，在函数调用之后会清空，否则还会一直存在
func

echo ${var}

