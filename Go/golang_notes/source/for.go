package main

import (
	"fmt"
)

func main() {

	var i int = 1
	for {
		var s string	//每次循环都是空
		if i == 1 {
			s = "nihao"
		}
		i++
		fmt.Println(i, s)
	}

	//依赖字符串、数组、slice等的数据类型的循环
	//range 产生 index, arg
/*
	s, sep := "", ""
	for _, arg := range os.Args[i:] {
		fmt.Println(arg)
	}
 */

	//正常的循环
/*
	for i := 1; i < 10; i++ {
		fmt.Println(i)
	}
 */

	//循环，只加判断，分号可以省略
/*
	var i int = 1
	for ;i < 10; {
		fmt.Println(i)
		i++
	}
 */

//	var s string = "in loop"
	//无限循环2
/*
	for {
		fmt.Println(s)
	}
 */

	//无限循环1
/*
	for ;; {
		fmt.Println(s)
	}
 */
}
