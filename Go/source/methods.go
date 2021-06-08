package main

import "fmt"

type rect struct {
	width, height int
}

/* 怎么理解这个函数定义 */
func (r *rect) area() int {
	return r.width * r.height
}

func (r rect) perim() int {
	return 2*r.width + 2*r.height
}

func (r *rect) change_w() {
	r.width = 22;
}
func (r rect) change_h() {
	r.height = 33;
}

func main() {
	r := rect{width:10, height:5}

	fmt.Println("area:", r.area())
	fmt.Println("perim:", r.perim())

	rp := &r
	fmt.Println("area:", rp.area())
	fmt.Println("perim:", rp.perim())

	/*
	 * 指针类型和数值调用方法的时候是一样的，
	 * 在参数传递的时候会有差别
	 */
	r.change_w();
	fmt.Println("width:", r.width)

	rp.change_h();
	fmt.Println("height:", r.height)
}

