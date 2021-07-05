package main

import (
	"fmt"
)

func main() {
	//调用顺序可以先与声明
	sayHello()
}

//函数语法:
//func funcName(args...) (retValue) {
//	函数体
//}
func sayHello() {
	fmt.Println("hello world")
}
