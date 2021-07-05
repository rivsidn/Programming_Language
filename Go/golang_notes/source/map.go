package main

import (
	"fmt"
)

func fun(m map[int]string) {
	m[3] = "ccc"

	m = map[int]string {
		1: "ddd",
		2: "eee",
		3: "fff",
	}
}

func main() {
	//map 是一个引用数据类型，传递给函数的是他的一个引用，
	//所以将在函数中改变m 的数据在main中会看到。
	//但是覆盖了map 的值在main 中却看不到。
	m3 := map[int]string {
		1:"aaa",
		2:"bbb",
	}
	fun(m3)
	for k,v := range m3 {
		fmt.Println(k, v)
	}

	fmt.Println("---------------------")

	//声明了一个map类型的变量但是没有创建，编译时候会报错
	//panic: assignment to entry in nil map
//	var m map[string]string

	//创建一个map(1)
//	var m = make(map[string]string)
	//创建一个map(2) 空
//	var m = map[string]string{}
	//创建一个map(3) 并赋值(1)
	var m = map[string]string{
		"bbb":"bbb",		//此处不添加逗号会报错
	}
	//类型赋值(2)
	m["aaa"] = "aaa"

	//删除一个map元素
	delete(m, "bbb")

	//map访问(1) 下标操作
	fmt.Println(m["aaa"])
	fmt.Println(m["bbb"])
	//map访问(2) 遍历操作，每次遍历的顺序都是变换
	fmt.Println("---------------------")
	for k, v := range m {
		fmt.Println(k, ":", v)
	}

	//判断key值是否存在
	//没存在的key, value会被初始化成对应的0 值，但是单纯通过判断vlaue 是否是对应的0 值没
	//办法确认该key 是否存在.
	//合理的方式是通过第二个参数来判断.
	fmt.Println("---------------------")
	var mm = map[string]int{
		"aaa":10,
	}
	va,ok := mm["aaa"]
	fmt.Println(va, ok)
	vb,ok := mm["bbb"]
	fmt.Println(vb, ok)

	dummy, ok := mm["aaa"]
	if (ok) {
		fmt.Println("exist :", dummy)	//存在
	} else {
		fmt.Println("do not exist")	//不存在
	}
}
