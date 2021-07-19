package main

import (
	"fmt"
)

/*
//错误，只能给本地的变量定义方法
func (i int) methodTest() {
	fmt.Println("int method test")
}
*/

type Point struct {
	X, Y int
}

//接收器就相当于函数中的参数，想要修改其中内容的时，需要传入指针类型
/*
func (p *Point) ScaleBy(factor int) {
	p.X *= factor
	p.Y *= factor
}
*/
//已经定义了前者的情况下，会报重复定义.
//当接收器不是指针的时候，(*Point) 也能调用ScaleBy() 函数，
//此时还是cp了变量，不会真正改变接收器的值
func (p Point) ScaleBy(factor int) {
	p.X *= factor
	p.Y *= factor
}

func main() {
	var p = Point{10, 20}

	(&p).ScaleBy(2)

	fmt.Println(p)
}

