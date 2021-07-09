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

	//切片初始化(1) 截取数组
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
	//切片初始化(2)
	//切片跟数组的差异就是，切片没指定长度，而数组指定了长度
	fmt.Println("---------------------")
	s := []int{0, 1, 2, 3, 4}
	fmt.Println(s)
	fmt.Printf("s len %d, s cap %d\n", len(s), cap(s))
	//切片初始化(3)
	fmt.Println("---------------------")
	s5 := make([]int, 10)		//len = 10
	s6 := make([]int, 10, 20)	//len = 10, cap = 20
	s5[0] = 1
	s6[0] = 2
	fmt.Println(s5)
	fmt.Println(s6)

/*
	//切片初始化(3) error
	fmt.Println("---------------------")
	var s2 []int		//仅做了声明但是没申请内存，此时的slice 为nil 值
	s2[0] = 10		//此时会失效
	fmt.Println(s2)
*/
/*
	//切片是否可比较 error
	//除了[]byte 可以通过bytes.Equal 比较，其他slice 的比较需要自己实现
	//可以跟 nil 比较
	var s3 = []int{1, 2, 3}
	var s4 = []int{1, 2, 3}
	if s3 == s4 {
		fmt.Println("equal")
	} else {
		fmt.Println("not equal")
	}
*/

	fmt.Println("---------------------")
	var s7 []int
	if s7 == nil {
		fmt.Println("s7 is nil")
	} else {
		fmt.Println("s7 is not nil")
	}

	//切片添加元素(1)
	//由于在append()中可能会重新申请内存，所以必须接收返回值
	fmt.Println("---------------------")
	s = append(s, 5)
	fmt.Println(s)
	fmt.Printf("s len %d, s cap %d\n", len(s), cap(s))
	//切片中添加元素(2)
	//调用了append() 之后，slice 没有重新申请内存，而是在之前数组上修改的
	Q2 = append(Q2, "this is a string")
	fmt.Println(Q2)
	fmt.Println(months)

	//切片作为函数参数
	//切片作为引用数据类型，实际就类似于C中的指针，作为参数传递给函数后，在参数中所做的
	//修改会影响到切片本身
	fmt.Println("---------------------")
	reverse(s)
	fmt.Println(s)


	//TODO:字符串和[]byte
}

func reverse(s []int) {
	for i,j := 0, len(s)-1; i<j; i,j = (i+1),(j-1) {
		s[i],s[j] = s[j], s[i]
	}
}

