package main

import (
	"fmt"
	"os"
)

func main() {
	var s, sep string

	for i := 1; i < len(os.Args); i++ {
		//字符串链接
		s += sep + os.Args[i]
		sep = " "
	}

	//输出
	fmt.Println(s)
}
