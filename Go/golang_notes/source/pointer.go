package main

import (
	"fmt"
)

func main() {
	var p *int

	var array = [5]int {
		1, 2, 3, 4, 5,		//此处必须要以逗号结尾
	}

	p = &array[0]

	fmt.Println(*p)
	/*
	fmt.Println(*(p+1))		//不允许指针运算
	*/
}
