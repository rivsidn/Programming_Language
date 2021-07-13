package main

import (
	"fmt"
	"unicode/utf8"
)

func main() {
	var s string = "你好"

	for i:=0; i < len(s); i++ {
		fmt.Printf("%b ", s[i])		//查看utf-8 编码格式
	}
	fmt.Println("")

	fmt.Println("------------------------")
	var s1 string = "Hello, 世界"
	fmt.Println(len(s1))
	fmt.Println(utf8.RuneCountInString(s1))
	for i := 0; i < len(s1); {
		r, size := utf8.DecodeRuneInString(s1[i:])
		fmt.Printf("%d\t%c\n", i, r)	//每次取一个字符打印输出
		i += size
	}

	fmt.Println("------------------------")
	var r = []rune(s1)
	fmt.Println(len(r))			//9
	r[2] = 0x30d7				//转换之后重新申请了内存，数值变成可以改变的
	r[3] = 0x30d7
	fmt.Println(r)

	fmt.Println("------------------------")
	/*
	var s2 string = "abcdefghijklmnopq"
	var bs []byte = s2[2:10]		//不能通过这种方式分配，报错
	fmt.Println(bs)
	*/

	fmt.Println("------------------------")
	var s3 string = "abc"
	var b3 = []byte(s3)			//会重新申请内存
	fmt.Println(s3)
	fmt.Println(b3)
	fmt.Println("------------------------")
	fmt.Println("------------------------")
	fmt.Println("------------------------")
}
