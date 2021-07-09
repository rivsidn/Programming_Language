package main

import (
	"fmt"
)

func main() {
	var s[]int

	for i := 0; i < 100; i++ {
		//当内存不够时，slice 将会以指数方式增加
		s = append(s, i)
		fmt.Println(cap(s))
	}

	fmt.Println("------------------")
	var s1[]int
	s1 = append(s1, 1, 2, 3)	//添加多个数值
	//TODO: 这是如何实现的？
	s1 = append(s1, s1...)		//添加slice
	fmt.Println(s1)
}
