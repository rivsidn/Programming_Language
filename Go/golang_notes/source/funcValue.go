package main

import (
	"fmt"
)

func square(n int) int {
	return n*n
}
func negative(n int) int {
	return n*(-1)
}

func main() {
	f := square
	fmt.Println(f(2))

	/*
	//编译不通过，只能根nil比较
	if f == square {
		fmt.Println("equal")
	} else {
		fmt.Println("not equal")
	}
	*/

	f = negative
	fmt.Println(f(3))
}
