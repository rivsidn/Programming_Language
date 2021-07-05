package main

import (
	"fmt"
)

//常量在编译期间就被计算，可以用来定义数组长度，类似于C中的宏定义
const len = 10
//批量常量定义
//如此操作之后，b=a=1, d=e=f=c=2
const (
	a = 1
	b
	c = 2
	d
	e
	f
)
//常量生成器
//类似与枚举，iota 最初被设置为 0，之后每行 +1
//常量与变量不同，即使用不到也不会报错，哈哈
type Weekday int
const (
	Sunday Weekday = iota
	Monday
	Tuesday
	Wednesday
	Thursday
	Friday
	Saturday
)

//TODO: 无类型整数常量转换成int，它的内存大小是不确定的。
//这句话怎么理解？

func main() {

	fmt.Println("-------------------")
	var aa = [len]int {
		1,2,3,4,5,6,7,8,9,10,
	}

	for _, v := range aa {
		fmt.Println(v)
	}

	fmt.Println("-------------------")

	fmt.Println(b)
	fmt.Println(f)
}
