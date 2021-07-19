package main

import (
	"fmt"
)

func squares() func() int {
	var x int
	f := func() int {
		x++			//函数内部可以访问到已经定义的局部变量，之后定义的变量不可以访问到
		return x * x
	}

	return f
}

func main() {
	f := squares()

	fmt.Println(f())
	fmt.Println(f())
	fmt.Println(f())
	fmt.Println(f())
}
