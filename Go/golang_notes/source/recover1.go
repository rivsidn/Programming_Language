package main

import (
	"fmt"
)

//revocer() 函数
//将发生异常的函数正常返回
func f() {
	defer func() {
		recover()
	}()

	panic("test")
}

func main() {
	f()
	fmt.Println("main")
}
