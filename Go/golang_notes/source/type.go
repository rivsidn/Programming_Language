package main

import (
	"fmt"
)

type Point struct {
	x, y int
}

func main() {
	var p Point		//结构体如何初始化

	p.x = 10
	p.y = 20

	fmt.Println(p)
}
