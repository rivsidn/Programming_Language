package main

import "fmt"

var a int = 10
var b int = a	//类似的操作在C中是不允许的

func main() {
	var t int = 10

	fmt.Println(a, b, t)
}
