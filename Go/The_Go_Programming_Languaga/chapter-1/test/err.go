package main

import (
	"fmt"
)

func main() {
	a, b := ret()
	/* 变量定义中必须有新变量，否则会报异常 */
	c, b := ret2()

	fmt.Println(a, b)
	fmt.Println(b, c)
}

func ret() (int, int) {
	return 10, 23
}

func ret2() (int, int) {
	return 20, 44
}
