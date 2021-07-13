package main

import "fmt"

func main() {
	//在不同的pc上，int 大小不是固定的，当前pc64位操作系统中int默认为8byte
	var aa [8]int8

	var p0 = &aa[0]
	var p1 = &aa[1]
	//打印查看数组中每个数组元素的间隔
	fmt.Println(p0, p1)

	fmt.Println("-----------------------")
	/*
	var bb int8 = 20
//	var cc int16 = 10
	var dd int = bb		//编译报错，此处没有隐式类型转换，只能强制类型转换
	fmt.Println(dd)
	*/

	fmt.Println("-----------------------")
	var ee rune = 10	//rune 和 int32 这两个类型是可以进行计算的
	var ff int32 = 20
	var gg = ee + ff
	fmt.Println(gg)

	fmt.Println("-----------------------")
	/*
	type testType int32	//type 之后是不能进行复制的，所以rune 和 byte 不是通过type来操作的
	var i1 testType = 10
	var i2 int32 = i1
	fmt.Println(i2)
	*/
}
