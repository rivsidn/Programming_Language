package main

import "fmt"

func main() {
	//string 并不是保留关键字，所以可以重新定义
	var string int = 10

	fmt.Println(string)
}
