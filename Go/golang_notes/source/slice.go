package main

import (
	"fmt"
)

//切片根数组很像，只是没有固定长度
//切片是引用数据类型，数组是复合数据类型

func main() {
	//切片是引用数据类型，声明并不会申请内存
	var Q2, summer []string

	var months = [...]string {
		1: "jan",
		2: "feb",
		3: "mar",
		4: "apr",
		5: "may",
		6: "jun",
		7: "jul",
		8: "aug",
		9: "sep",
		10: "oct",
		11: "nov",
		12: "dec",
	}

	//切片初始化(1)
	//切片有三部分组成：指针，长度，容量
	//切片并没有申请内存，可以通过指针指向数组的内存，长度比较容易理解，容量是从
	//切片开始位置到数组结束位置，长度可以拓展，但不能超过容量。
	Q2 = months[4:7]
	summer = months[6:9]
	fmt.Printf("Q2 len %d, Q2 cap %d\n", len(Q2), cap(Q2))
	for i, v := range Q2 {
		fmt.Println(i, ":", v)
	}
	fmt.Printf("summer len %d, summer cap %d\n", len(summer), cap(summer))
	for i, v := range summer {
		fmt.Println(i, ":", v)
	}

	//TODO: 未完待续...
}

