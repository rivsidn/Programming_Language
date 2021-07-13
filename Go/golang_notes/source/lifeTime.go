package main

import (
	"fmt"
)

func main() {
	for i := 0; i < 10; i++ {
		var x int = 10
		fmt.Println(&x)		//每次申请的地址都不同，C语言中每次打印的地址都相同
	}
}
