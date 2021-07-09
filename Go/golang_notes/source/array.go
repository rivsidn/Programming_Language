package main

import (
	"fmt"
)

//数组、结构体 在Go 中称为复合数据类型；
//声明时，数组长度就已经确定了，同时就已经结束申请内存了.

func main() {
	//数组初始化(1) 数组长度是数组的一部分，必须在编译时候就确定
	var a [3]int
	//数组赋值
	a[1] = 10
	//数组遍历(1)
	for i, v := range a {
		fmt.Println(i, ":", v)
	}

	fmt.Println("------------")
	//数组初始化(2)
	var a1 = [3]int {
		1, 2, 3,
	}
	for i, v := range a1 {
		fmt.Println(i, ":", v)
	}

	fmt.Println("------------")
	//数组初始化(3)
	var a2 = [...]int {
		1, 2, 3, 4,
	}
	for i, v := range a2 {
		fmt.Println(i, ":", v)
	}
	//数组初始化(4)
	var a4 = [...]int {
		11:10,
	}
	for i, v := range a4 {
		fmt.Println(i, ":", v)
	}
/*
	//数组初始化(5) error
	//必须要指定 var a5 = [5]int{1, 2, 3}
	var a5 [5]int = {1, 2, 3}
	fmt.Println(a5)
*/
	//数组比较
	//两个相同类型的数组是可以比较的，不同类型的数组没法比较
	var aa = [2]int{1, 2}
	var bb = [...]int{1, 2}
	if aa == bb {
		fmt.Println("equal")
	} else {
		fmt.Println("not equal")
	}
/*
	//此时会编译不通过, 两个数组类型不同
	var cc = [3]int{}
	if aa == cc {
		fmt.Println("equal")
	} else {
		fmt.Println("not equal")
	}
*/

	//数组函数调用
	var a3  = [3]int{10, 11, 12}
	f(a3)
	for i, v := range a3 {
		fmt.Println(i, ":", v)
	}
}

//当数组作为参数传递给函数的时候，会将数组复制一份传递给函数.
//1. 在函数中修改数组内容不会对调用处的数组产生影响
//2. 当数组太大会影响性能
//
//数组在Go称为复合数据类型而不是引用数据类型
func f(arr [3]int) {
	arr[2] = 200
}

